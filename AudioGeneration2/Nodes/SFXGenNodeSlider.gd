extends MarginContainer
class_name SFXGenNodeSlider

var minus_button:Button = null
var plus_button:Button = null
var property_label:Label = null
var value_label:Label = null
var value_line_edit:LineEdit = null

func set_property_name(name:String):
	property_label.text = name

# Slider properties/signals/methods
signal value_changed
signal property_changed

var slider_dragging:bool = false
var slider_drag_start_position:Vector2
var slider_drag_start_value:float = 0.0

var value:float = 0.0 setget set_value,get_value
func set_value(new_value:float):
	if (minus_button == null and plus_button == null):
		value = clamp(new_value,min_value,max_value)
	else:
		value = new_value
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
	if (minus_button != null):
		minus_button.visible = !minus_button.visible
	if (plus_button != null):
		plus_button.visible = !plus_button.visible
	value_line_edit.visible = !value_line_edit.visible
	value_label.visible = !value_label.visible
	property_label.visible = !property_label.visible

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
	 
	if (slider_drag_start_value == value):
		value_line_edit.text = value_label.text
		value_line_edit.grab_focus()
		value_line_edit.select_all()
		warp_mouse(slider_drag_start_position)
		toggle_gui()
	else:
		if (minus_button != null and plus_button != null):
			warp_mouse(slider_drag_start_position)
		else:
			var hbox = get_child(0)
			var offset = (value - min_value) / (max_value - min_value)
			warp_mouse(Vector2(hbox.rect_size.x * offset, hbox.rect_size.y / 2))

func apply_new_text_change(new_text:String):
	if (new_text.is_valid_float()):
		set_value(float(new_text))
	else:
		value_line_edit.text = "%1.3f" % get_value()

func _init(clamped:bool):
	mouse_filter = MOUSE_FILTER_PASS
	
	var hbox:HBoxContainer = HBoxContainer.new()
	hbox.mouse_filter = MOUSE_FILTER_STOP
	hbox.connect("gui_input",self,"_on_hbox_gui_input")
	add_child(hbox)
	
	if (!clamped):
		var button_normal_stylebox:StyleBoxFlat = StyleBoxFlat.new()
		button_normal_stylebox.bg_color = Color(0.3,0.3,0.3)
		button_normal_stylebox.content_margin_left = 4
		button_normal_stylebox.content_margin_right = 4
	
		var button_hover_stylebox:StyleBoxFlat = StyleBoxFlat.new()
		button_hover_stylebox.bg_color = Color(0.25,0.25,0.25)
		button_hover_stylebox.content_margin_left = 4
		button_hover_stylebox.content_margin_right = 4
	
		var button_pressed_stylebox:StyleBoxFlat = StyleBoxFlat.new()
		button_pressed_stylebox.bg_color = Color(0.2,0.2,0.2)
		button_pressed_stylebox.content_margin_left = 4
		button_pressed_stylebox.content_margin_right = 4
	
		minus_button = Button.new()
		minus_button.text = "<"
		minus_button.add_stylebox_override("normal", button_normal_stylebox)
		minus_button.add_stylebox_override("hover", button_hover_stylebox)
		minus_button.add_stylebox_override("pressed", button_pressed_stylebox)
		minus_button.connect("pressed",self,"_on_minus_button_pressed")
		hbox.add_child(minus_button)
		
		plus_button = Button.new()
		plus_button.text = ">"
		plus_button.add_stylebox_override("normal", button_normal_stylebox)
		plus_button.add_stylebox_override("hover", button_hover_stylebox)
		plus_button.add_stylebox_override("pressed", button_pressed_stylebox)
		plus_button.connect("pressed",self,"_on_plus_button_pressed")
	
	property_label = Label.new()
	property_label.text = "Property"
	property_label.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(property_label)
	
	value_label = Label.new()
	value_label.align = Label.ALIGN_RIGHT
	value_label.rect_min_size.x = 120
	value_label.size_flags_horizontal = SIZE_EXPAND_FILL
	value_label.text = "%1.3f" % value
	value_label.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(value_label)
	
	if (!clamped):
		hbox.add_child(plus_button)
	
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
	draw_rect(Rect2(hbox.rect_position,hbox.rect_size),Color(0.5,0.5,0.5,1.0))
	
	if (minus_button == null and plus_button == null and value > 0 and !value_line_edit.visible):
		var m:float = (value - min_value) / (max_value - min_value)
		var value_size:Vector2 = Vector2(hbox.rect_size.x * m, hbox.rect_size.y)
		draw_rect(Rect2(hbox.rect_position,value_size),Color(0.5,0.5,0.7,1.0))

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

func _on_value_line_edit_text_entered(new_text:String):
	value_line_edit.release_focus()

func _on_value_line_edit_focus_exited():
	apply_new_text_change(value_line_edit.text)
	toggle_gui()

func _on_minus_button_pressed():
	set_value(value - step)

func _on_plus_button_pressed():
	set_value(value + step)
