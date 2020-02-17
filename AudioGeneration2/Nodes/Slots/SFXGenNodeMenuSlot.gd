extends SFXGenNodeSlot
class_name SFXGenNodeMenuSlot

func _init(option_array:Array = [], start_index:int = 0):
	._init()
	
	var margin_container:PanelContainer = PanelContainer.new()
	add_child(margin_container)
	
	var menu_button:MenuButton = MenuButton.new()
	var popup:PopupMenu = menu_button.get_popup()
	if (option_array.size() > 0):
		var option:String
		for option in option_array:
			if (option[0] == "-"):
				popup.add_separator(option.replace("-",""))
			else:
				popup.add_item(option)
		menu_button.text = popup.get_item_text(start_index)
	
	
	popup.connect("id_pressed", self, "_on_menu_id_pressed")

	margin_container.add_child(menu_button)

func _draw():
	var menu_button:Control = get_menu_button()
	draw_rect(Rect2(menu_button.rect_position,menu_button.rect_size),Color.black,false)

func get_menu_button():
	return get_child(0).get_child(0)

func get_menu_popup():
	return get_menu_button().get_popup()

signal menu_item_selected
func _on_menu_id_pressed(id:int):
	emit_signal("menu_item_selected",id)
	get_menu_button().text = get_menu_popup().get_item_text(id)
