extends MarginContainer
class_name SFXGenNodeSliderSlot

var property_label:Label = null
var value_label:Label = null
var value_line_edit:LineEdit = null
var spacer_control:Control = null

# Slider properties/signals/methods
signal value_changed
signal property_changed

var slider_dragging:bool = false
var slider_drag_start_position:Vector2
var slider_drag_start_value:float = 0.0

var value:float = 0.0 setget set_value,get_value
func set_value(new_value:float):
	value = clamp(new_value,min_value,max_value)
	value_label.text = "%1.3f" % value
	update()
	emit_signal("value_changed",value)
func get_value():
	return value

var step:float = 0.001 setget set_step,get_step
func set_step(new_step:float):
	step = new_step
	emit_signal("property_changed",step)
func get_step():
	return step

var min_value:float = 0.0 setget set_min_value,get_min_value
func set_min_value(new_min:float):
	min_value = new_min
	emit_signal("property_changed",min_value)
func get_min_value():
	return min_value

var max_value:float = 1.0 setget set_max_value,get_max_value
func set_max_value(new_min:float):
	max_value = new_min
	emit_signal("property_changed",max_value)
func get_max_value():
	return max_value

func toggle_gui():
	value_line_edit.visible = !value_line_edit.visible
	value_label.visible = !value_label.visible
	spacer_control.visible = !spacer_control.visible
	property_label.visible = !property_label.visible

func _init():
	mouse_filter = MOUSE_FILTER_PASS
	
	var hbox:HBoxContainer = HBoxContainer.new()
	hbox.mouse_filter = MOUSE_FILTER_STOP
	hbox.connect("gui_input",self,"_on_hbox_gui_input")
	add_child(hbox)
	
	property_label = Label.new()
	property_label.text = "Property"
	property_label.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(property_label)
	
	spacer_control = Control.new()
	spacer_control.rect_min_size.x = 100
	spacer_control.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(spacer_control)
	
	value_label = Label.new()
	value_label.text = "%1.3f" % value
	value_label.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(value_label)
	
	var line_edit_stylebox:StyleBoxFlat = StyleBoxFlat.new()
	line_edit_stylebox.bg_color = Color(0.0, 0.0, 0.0, 0.0)
	
	value_line_edit = LineEdit.new()
	value_line_edit.add_stylebox_override("normal",line_edit_stylebox)
	value_line_edit.add_stylebox_override("focus",line_edit_stylebox)
	value_line_edit.text = value_label.text
	value_line_edit.mouse_filter = MOUSE_FILTER_STOP
	value_line_edit.connect("text_entered",self,"_on_value_line_edit_text_entered")
	value_line_edit.connect("focus_exited",self,"_on_value_line_edit_focus_exited")
	value_line_edit.visible = false
	hbox.add_child(value_line_edit)

func _draw():
	var hbox = get_child(0)
	draw_rect(Rect2(hbox.rect_position,hbox.rect_size),Color(0.4,0.4,0.4,1.0))
	
	if (value > 0 and !value_line_edit.visible):
		var m:float = (value - min_value) / (max_value - min_value)
		var value_size:Vector2 = Vector2(hbox.rect_size.x * m, hbox.rect_size.y)
		draw_rect(Rect2(hbox.rect_position,value_size),Color(0.5,0.5,0.7,1.0))

func start_dragging(start_pos:Vector2):
	slider_dragging = true
	slider_drag_start_position = start_pos
	slider_drag_start_value = value
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func process_dragging(amount:float):
	var hbox = get_child(0)
	var new_value = get_value() + step * amount
	set_value(new_value)

func stop_dragging(stop_pos:Vector2):
	slider_dragging = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# if user just clicked then 
	if (slider_drag_start_value == value):
		value_line_edit.text = value_label.text
		value_line_edit.grab_focus()
		value_line_edit.select_all()
		warp_mouse(slider_drag_start_position)
		toggle_gui()
	else:
		var hbox = get_child(0)
		var offset = (value - min_value) / (max_value - min_value)
		warp_mouse(Vector2(hbox.rect_size.x * offset, hbox.rect_size.y / 2))

func _on_hbox_gui_input(e):
	if (e is InputEventMouseButton):
		var mb:InputEventMouseButton = e
		if (mb.button_index == 1):
			if (!slider_dragging and mb.is_pressed()):
				start_dragging(mb.position)
			elif (slider_dragging and !mb.is_pressed()):
				stop_dragging(mb.position)
	
	if (slider_dragging and e is InputEventMouseMotion):
		process_dragging(e.relative.x)

func apply_new_text_change(new_text:String):
	if (new_text.is_valid_float()):
		set_value(float(new_text))
	else:
		value_line_edit.text = "%1.3f" % get_value()

func _on_value_line_edit_text_entered(new_text:String):
	apply_new_text_change(new_text)
	value_line_edit.release_focus()

func _on_value_line_edit_focus_exited():
	apply_new_text_change(value_line_edit.text)
	toggle_gui()
