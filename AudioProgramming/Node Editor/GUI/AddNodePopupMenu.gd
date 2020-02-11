extends PopupMenu
class_name AddNodePopupMenu

func _init():
	add_separator("Add Node")
	add_item("Oscillator", Globals.NODE_TYPE_OSCILLATOR)
	add_item("Audio Output", Globals.NODE_TYPE_AUDIO_OUTPUT)
	add_item("Math", Globals.NODE_TYPE_MATH)
	add_separator()
