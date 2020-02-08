extends GraphNode
class_name AudioOutputNode

var audio_stream_player:AudioStreamPlayer = null
var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var sample_rate_label:Label = null
var sample_rate_text:LineEdit = null
var stream_input_label:Label = null

func _on_sample_rate_text_entered(new_text:String):
	if (new_text.is_valid_integer()):
		sample_rate_text.text = new_text
		audio_stream_player.stream.mix_rate = int(new_text)
	else:
		sample_rate_text.text = sample_rate_text.placeholder_text

func _on_resize_request(min_size:Vector2):
	rect_size = min_size

func _init():
	title = "Audio Output"
	
	#resizable = true
	#connect("resize_request",self,"_on_resize_request")
	
	slot0 = HBoxContainer.new()
	slot1 = HBoxContainer.new()
	add_child(slot0)
	add_child(slot1)
	
	sample_rate_label = Label.new()
	sample_rate_label.text = "Sample Rate"
	sample_rate_text = LineEdit.new()
	sample_rate_text.text = "44100"
	sample_rate_text.placeholder_text = "44100"
	sample_rate_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	sample_rate_text.connect("text_entered",self,"_on_sample_rate_text_entered")
	
	var spacer_control = Control.new()
	spacer_control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	slot0.add_child(sample_rate_label)
	slot0.add_child(sample_rate_text)
	slot0.add_child(spacer_control)
	
	stream_input_label = Label.new()
	stream_input_label.text = "Stream Input"
	stream_input_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	slot1.add_child(stream_input_label)
	
	set_slot(0,true,Globals.SLOT_TYPE_INT,Globals.SLOT_COLOR_INT,false,-1,-1)
	set_slot(1,true,Globals.SLOT_TYPE_REAL,Globals.SLOT_COLOR_REAL,false,-1,-1)
	
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = AudioStreamGenerator.new()
	add_child(audio_stream_player)
