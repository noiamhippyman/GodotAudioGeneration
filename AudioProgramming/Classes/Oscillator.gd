extends Node
class_name Oscillator

enum eWaveType {
	Sine,Square,Sawtooth,Triangle
}

const TWOPI = 2 * PI

export(eWaveType) var wave_type:int setget set_wave_type
func set_wave_type(type:int):
	wave_type = type
	phase = 0.0
var sample_rate:float
export(float) var frequency:float
export(float) var peak_amplitude:float

onready var phase:float = 0.0
onready var amplitude:float = 0.0

func get_sample():
	return amplitude

func process():
	match wave_type:
		eWaveType.Sine:
			amplitude = peak_amplitude * sin(phase)
		eWaveType.Square:
			if (phase < PI):
				amplitude = peak_amplitude
			else:
				amplitude = -peak_amplitude
		eWaveType.Sawtooth:
			amplitude = peak_amplitude - (peak_amplitude / PI * phase)
		eWaveType.Triangle:
			if (phase < PI):
				amplitude = -peak_amplitude + (2 * peak_amplitude / PI) * phase
			else:
				amplitude = 3 * peak_amplitude - (2 * peak_amplitude / PI) * phase
	
	phase += (TWOPI * frequency) / sample_rate
	if (phase > TWOPI):
		phase -= TWOPI
