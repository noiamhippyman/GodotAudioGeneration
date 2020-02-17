extends SFXGenNodeSlot
class_name SFXGenNodeOutputSlot

func _init(output_text:String = "Value"):
	._init()
	
	var hbox = HBoxContainer.new()
	hbox.size_flags_horizontal = SIZE_EXPAND_FILL
	hbox.alignment = HBoxContainer.ALIGN_END
	var label = Label.new()
	label.text = output_text
	hbox.add_child(label)
	add_child(hbox)
