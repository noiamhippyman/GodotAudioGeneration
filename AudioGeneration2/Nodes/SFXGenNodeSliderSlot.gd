extends MarginContainer
class_name SFXGenNodeSliderSlot

var property_label:Label = null
var value_label:Label = null
var slider:HSlider = null

func set_property_name(name:String):
	property_label.text = name
func set_property_value(value:float):
	value_label.text = "%1.2f" % value
	
	
func set_min_value(value:float):
	slider.min_value = value
	slider.value = clamp(slider.value,slider.min_value,slider.max_value)
func set_max_value(value:float):
	slider.max_value = value
	slider.value = clamp(slider.value,slider.min_value,slider.max_value)
func set_step_value(value:float):
	slider.step = value
func set_value(value:float):
	slider.value = value
	set_property_value(value)


func _init():
	mouse_filter = MOUSE_FILTER_PASS
	
	var slider_stylebox:StyleBoxFlat = StyleBoxFlat.new()
	slider_stylebox.bg_color = Color(1.0,1.0,1.0,0.4)
	slider_stylebox.corner_radius_top_left = 4
	slider_stylebox.corner_radius_top_right = 4
	slider_stylebox.corner_radius_bottom_left = 4
	slider_stylebox.corner_radius_bottom_right = 4
	slider_stylebox.anti_aliasing = false
	slider_stylebox.content_margin_top = 8
	slider_stylebox.content_margin_bottom = 8
	var grabber_stylebox:StyleBoxFlat = StyleBoxFlat.new()
	grabber_stylebox.bg_color = Color(0.5,0.5,0.7,1.0)
	grabber_stylebox.corner_radius_top_left = 4
	grabber_stylebox.corner_radius_top_right = 4
	grabber_stylebox.corner_radius_bottom_left = 4
	grabber_stylebox.corner_radius_bottom_right = 4
	grabber_stylebox.anti_aliasing = false
	
	var empty_texture:ImageTexture = ImageTexture.new()
	
	slider = HSlider.new()
	slider.size_flags_horizontal = SIZE_FILL
	slider.size_flags_vertical = SIZE_FILL
	slider.mouse_filter = MOUSE_FILTER_STOP
	slider.add_stylebox_override("slider",slider_stylebox)
	slider.add_stylebox_override("grabber_area",grabber_stylebox)
	slider.add_icon_override("grabber",empty_texture)
	slider.add_icon_override("grabber_disabled",empty_texture)
	slider.add_icon_override("grabber_highlight",empty_texture)
	slider.connect("value_changed",self,"_on_slider_value_changed")
	add_child(slider)
	
	var hbox:HBoxContainer = HBoxContainer.new()
	hbox.mouse_filter = MOUSE_FILTER_IGNORE
	add_child(hbox)
	
	property_label = Label.new()
	property_label.text = "Property"
	property_label.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(property_label)
	
	var spacer_control:Control = Control.new()
	spacer_control.rect_min_size.x = 100
	spacer_control.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(spacer_control)
	
	value_label = Label.new()
	value_label.text = "0.0"
	value_label.mouse_filter = MOUSE_FILTER_IGNORE
	hbox.add_child(value_label)

func _on_slider_value_changed(value:float):
	set_property_value(value)
