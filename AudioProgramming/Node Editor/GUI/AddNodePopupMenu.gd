extends PopupMenu
class_name AddNodePopupMenu

func _init():
	add_separator("Add Node")
	add_separator("Audio")
	add_item("Oscillator", Globals.NODE_TYPE_OSCILLATOR)
	add_item("Envelope", Globals.NODE_TYPE_ENVELOPE)
	add_item("4-Pole Filter", Globals.NODE_TYPE_4POLE_FILTER)
	add_item("Audio Output", Globals.NODE_TYPE_AUDIO_OUTPUT)
	add_separator("Variables")
	add_item("Boolean", Globals.NODE_TYPE_BOOL)
	add_item("Integer", Globals.NODE_TYPE_INT)
	add_item("Float", Globals.NODE_TYPE_REAL)
	add_item("String", Globals.NODE_TYPE_STRING)
	add_item("Vector2", Globals.NODE_TYPE_VECTOR2)
	add_item("Vector3", Globals.NODE_TYPE_VECTOR3)
	add_separator("Misc")
	add_item("Math", Globals.NODE_TYPE_MATH)
