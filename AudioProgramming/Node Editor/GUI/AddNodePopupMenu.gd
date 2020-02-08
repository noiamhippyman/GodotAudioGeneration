extends PopupMenu
class_name AddNodePopupMenu

func _init():
	add_separator("Add")
	add_item("Oscillator", Globals.NODE_TYPE_OSCILLATOR)
	add_item("Audio Output", Globals.NODE_TYPE_AUDIO_OUTPUT)
