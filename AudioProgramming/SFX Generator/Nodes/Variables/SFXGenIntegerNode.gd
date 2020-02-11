extends SFXGenNode
class_name SFXGenIntegerNode

var slot0:HBoxContainer = null

func _init():
	title = "Integer"
	
	slot0 = add_slot_control(-1,Globals.SLOT_TYPE_INT)
	slot0.alignment = HBoxContainer.ALIGN_END
	
	var label:Label = Label.new()
	label.text = "Value"
	slot0.add_child(label)
	
	var line:LineEdit = LineEdit.new()
	line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot0.add_child(line)
