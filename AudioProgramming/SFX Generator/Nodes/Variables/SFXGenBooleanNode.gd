extends SFXGenNode
class_name SFXGenBooleanNode

var slot0:HBoxContainer = null

func _init():
	title = "Boolean"
	
	slot0 = add_slot_control(-1,Globals.SLOT_TYPE_BOOL)
	
	var checkbox:CheckBox = CheckBox.new()
	checkbox.text = "Enabled"
	checkbox.align = CheckBox.ALIGN_RIGHT
	slot0.add_child(checkbox)
