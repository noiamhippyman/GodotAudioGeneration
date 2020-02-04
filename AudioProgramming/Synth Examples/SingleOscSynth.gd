extends Node

var oscillator:Oscillator
var player:AudioStreamPlayer
export(float) var sample_rate:float = 22050.0

func fill_buffer():
	var playback:AudioStreamGeneratorPlayback = player.get_stream_playback()
	var frames:int = playback.get_frames_available()
	while (frames > 0):
		
		oscillator.process()
		var sample = oscillator.get_sample()
		playback.push_frame(Vector2(sample,sample))
		
		frames -= 1

func _ready():
	oscillator = $Oscillator
	oscillator.sample_rate = sample_rate
	
	player = $AudioStreamPlayer
	player.stream.mix_rate = sample_rate
	
	fill_buffer()
	player.play()

func _process(delta):
	fill_buffer()
