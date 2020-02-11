extends Node
class_name FilterResonant

enum eFilterMode {
	Lowpass,Highpass,Bandpass
}

var cutoff_mod:float setget set_cutoff_mod
func set_cutoff_mod(new_cutoff_mod:float):
	cutoff_mod = new_cutoff_mod
	calculate_feedback_amount()

export(float) var cutoff:float setget set_cutoff
func set_cutoff(new_cutoff:float):
	cutoff = new_cutoff
	calculate_feedback_amount()

export(float) var resonance:float setget set_resonance
func set_resonance(new_resonance:float):
	resonance = new_resonance
	calculate_feedback_amount()

export(eFilterMode) var mode:int

var feedback_amount:float
var buf0:float
var buf1:float
var buf2:float
var buf3:float

func _init():
	cutoff = 0.99
	cutoff_mod = 0.0
	resonance = 0.0
	mode = eFilterMode.Lowpass
	buf0 = 0.0
	buf1 = 0.0
	buf2 = 0.0
	buf3 = 0.0
	calculate_feedback_amount()

func get_calculated_cutoff():
	return max(min(cutoff + cutoff_mod, 0.99),0.01)

func calculate_feedback_amount():
	feedback_amount = resonance + resonance / (1.0 - get_calculated_cutoff())

func process(input:float):
	if (input == 0.0):
		return input
	var calculated_cutoff:float = get_calculated_cutoff()
	buf0 += calculated_cutoff * (input - buf0 + feedback_amount * (buf0 - buf1))
	buf1 += calculated_cutoff * (buf0 - buf1)
	buf2 += calculated_cutoff * (buf1 - buf2)
	buf3 += calculated_cutoff * (buf2 - buf3)
	match mode:
		eFilterMode.Lowpass:
			return buf3
		eFilterMode.Highpass:
			return input - buf3
		eFilterMode.Bandpass:
			return buf0 - buf3
