extends GraphNode
class_name SFXGenNode

func add_slot_slider(name:String, clamped:bool = true):
	var slider:SFXGenNodeSliderSlot = SFXGenNodeSliderSlot.new(clamped)
	slider.set_property_name(name)
	add_child(slider)
	set_slot(get_child_count()-1,true,0,Color.azure,false,-1,-1)
	return slider

func add_slot_menu(option_array:Array = [], start_index:int = 0):
	var slot:SFXGenNodeMenuSlot = SFXGenNodeMenuSlot.new(option_array, start_index)
	add_child(slot)
	return slot

func add_slot_output(output_text:String = "Value"):
	var slot:SFXGenNodeOutputSlot = SFXGenNodeOutputSlot.new(output_text)
	add_child(slot)
	set_slot(get_child_count()-1,false,-1,-1,true,0,Color.azure)

#func add_slot(clamped:bool,slot_type:int,slot_data_type:int):
#	var slot:Control = null
#	var slot_index:int = get_child_count()
#	if (slot_type == eSlotType.Out or slot_type == eSlotType.NoSlot):
#		slot = HBoxContainer.new()
#		slot.size_flags_horizontal = SIZE_EXPAND_FILL
#		slot.alignment = HBoxContainer.ALIGN_END
#		if (slot_type == eSlotType.Out):
#			set_slot(slot_index,false,-1,-1,true,slot_data_type,Color.gray)
#			var label = Label.new()
#			label.text = "Output"
#			slot.add_child(label)
#			add_child(slot)
#	else:
#		slot = SFXGenNodeSlider.new(clamped)
#		add_child(slot)
#		set_slot(slot_index,true,slot_data_type,Color.gray,false,-1,-1)
#	return slot

#extends GraphNode
#class_name SFXGenNode
#
#func get_color_from_type(type:int):
#	var color:Color
#	match type:
#		Globals.SLOT_TYPE_BOOL:
#			color = Globals.SLOT_COLOR_BOOL
#		Globals.SLOT_TYPE_INT:
#			color = Globals.SLOT_COLOR_INT
#		Globals.SLOT_TYPE_REAL:
#			color = Globals.SLOT_COLOR_REAL
#		Globals.SLOT_TYPE_STRING:
#			color = Globals.SLOT_COLOR_STRING
#		Globals.SLOT_TYPE_VECTOR2:
#			color = Globals.SLOT_COLOR_VECTOR2
#		Globals.SLOT_TYPE_VECTOR3:
#			color = Globals.SLOT_COLOR_VECTOR3
#	return color
#
#func add_slot_control(type_input:int,type_output:int):
#	var slot_hbox:HBoxContainer = HBoxContainer.new()
#	var slot_count = get_child_count()
#	slot_hbox.name = "Slot " + str(slot_count)
#	var has_input:bool = type_input >= 0
#	var has_output:bool = type_output >= 0
#	var color_input:Color = get_color_from_type(type_input)
#	var color_output:Color = get_color_from_type(type_output)
#	set_slot(slot_count,type_input >= 0,type_input,color_input,type_output >= 0,type_output,color_output)
#	add_child(slot_hbox)
#	return slot_hbox
#
#func set_slot_io(index:int,type_input:int,type_output:int):
#	if (index < 0 or index >= get_child_count()):
#		return
#	var has_input:bool = type_input >= 0
#	var has_output:bool = type_output >= 0
#	var color_input:Color = get_color_from_type(type_input)
#	var color_output:Color = get_color_from_type(type_output)
#	set_slot(index,type_input >= 0,type_input,color_input,type_output >= 0,type_output,color_output)
#
#func remove_slot_control(index:int):
#	if (index < 0 or index >= get_child_count()):
#		return
#	var slot = get_slot_control(index)
#	slot.queue_free()
#
#func get_slot_control(index:int):
#	return get_child(index)
#
#func add_control_to_slot_control(index:int,control:Control):
#	if (index < 0 or index >= get_child_count()):
#		return
#	get_slot_control(index).add_child(control)
#
#func add_spacer_to_slot_control(index:int):
#	if (index < 0 or index >= get_child_count()):
#		return
#	var slot:HBoxContainer = get_slot_control(index)
#	var spacer_control:Control = Control.new()
#	spacer_control.size_flags_horizontal = SIZE_EXPAND_FILL
#	slot.add_child(spacer_control)
