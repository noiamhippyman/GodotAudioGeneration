extends SFXGenNode
class_name SFXGenVector2Node

var slot0:HBoxContainer = null
var slot1:HBoxContainer = null

func _init():
	title = "Vector2"
	
	slot0 = add_slot_control(-1,Globals.SLOT_TYPE_REAL)
	slot0.alignment = HBoxContainer.ALIGN_END
	slot1 = add_slot_control(-1,Globals.SLOT_TYPE_REAL)
	slot1.alignment = HBoxContainer.ALIGN_END
	
	var label:Label = Label.new()
	label.text = "X"
	slot0.add_child(label)
	
	var line:LineEdit = LineEdit.new()
	line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot0.add_child(line)
	
	label = Label.new()
	label.text = "Y"
	slot1.add_child(label)
	
	line = LineEdit.new()
	line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot1.add_child(line)
