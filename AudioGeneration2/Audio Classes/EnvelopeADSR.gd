extends Node
class_name EnvelopeADSR

enum eEnvelopeStage {
	Idle, 
	Attack, 
	Decay, 
	Sustain, 
	Release
}

const minimum_level:float = 0.001
var current_stage:int
var current_level:float
var multiplier:float
var sample_rate:float

var current_sample_index:int
var next_stage_sample_index:int
var stage_value:PoolRealArray

export(float) var attack setget set_attack
export(float) var decay setget set_decay
export(float) var sustain setget set_sustain
export(float) var release setget set_release
func set_attack(seconds:float):
	attack = seconds
	stage_value[eEnvelopeStage.Attack] = seconds
func set_decay(seconds:float):
	decay = seconds
	stage_value[eEnvelopeStage.Decay] = seconds
func set_sustain(level:float):
	sustain = level
	stage_value[eEnvelopeStage.Sustain] = level
func set_release(seconds:float):
	release = seconds
	stage_value[eEnvelopeStage.Release] = seconds

func _init():
	current_stage = eEnvelopeStage.Idle
	current_level = minimum_level
	multiplier = 1.0
	current_sample_index = 0
	next_stage_sample_index = 0
	stage_value.resize(5)
	set_attack(0.01)
	set_decay(0.5)
	set_sustain(0.1)
	set_release(1.0)

func enter_stage(new_stage:int):
	current_stage = new_stage
	current_sample_index = 0
	if (current_stage == eEnvelopeStage.Idle or current_stage == eEnvelopeStage.Sustain):
		next_stage_sample_index = 0
	else:
		next_stage_sample_index = stage_value[current_stage] * sample_rate
	match current_stage:
		eEnvelopeStage.Idle:
			current_level = 0.0
			multiplier = 1.0
		eEnvelopeStage.Attack:
			current_level = minimum_level
			calculate_multiplier(current_level,1.0,next_stage_sample_index)
		eEnvelopeStage.Decay:
			current_level = 1.0
			calculate_multiplier(current_level,max(stage_value[eEnvelopeStage.Sustain],minimum_level),next_stage_sample_index)
		eEnvelopeStage.Sustain:
			current_level = stage_value[eEnvelopeStage.Sustain]
			multiplier = 1.0
		eEnvelopeStage.Release:
			calculate_multiplier(current_level,minimum_level,next_stage_sample_index)

func next_sample():
	if (current_stage != eEnvelopeStage.Idle and current_stage != eEnvelopeStage.Sustain):
		if (current_sample_index == next_stage_sample_index):
			var new_stage = (current_stage + 1) % 5
			enter_stage(new_stage)
		current_level *= multiplier
		current_sample_index += 1
	return current_level

func calculate_multiplier(start_level:float,end_level:float,sample_count:int):
	multiplier = 1.0 + (log(end_level) - log(start_level)) / sample_count
