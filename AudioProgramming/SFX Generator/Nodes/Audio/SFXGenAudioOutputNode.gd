extends SFXGenNode
class_name SFXGenAudioOutputNode

var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var slot2:HBoxContainer = null
var audio_stream_player:AudioStreamPlayer = null

func _init():
	title = "Audio Output"
	
	slot0 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	slot1 = add_slot_control(Globals.SLOT_TYPE_INT,-1)
	slot2 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = AudioStreamGenerator.new()
	
	var length_label:Label = Label.new()
	length_label.text = "Length (sec)"
	slot0.add_child(length_label)
	
	var length_line:LineEdit = LineEdit.new()
	length_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot0.add_child(length_line)
	add_spacer_to_slot_control(0)
	
	var sample_rate_label:Label = Label.new()
	sample_rate_label.text = "Sample Rate"
	slot1.add_child(sample_rate_label)
	
	var sample_rate_line:LineEdit = LineEdit.new()
	sample_rate_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot1.add_child(sample_rate_line)
	add_spacer_to_slot_control(1)
	
	var sample_input_label:Label = Label.new()
	sample_input_label.text = "Sample"
	slot2.add_child(sample_input_label)
