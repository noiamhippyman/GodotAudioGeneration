extends SFXGenNodeSlot
class_name SFXGenNodeMenuSlot

func _init(option_array:Array = []):
	._init()
	
	var panel_container:PanelContainer = PanelContainer.new()
	add_child(panel_container)
	
	var menu_button:MenuButton = MenuButton.new()
	var popup:PopupMenu = menu_button.get_popup()
	for option in option_array:
		popup.add_item(option)
	popup.connect("id_pressed", self, "_on_menu_id_pressed")

	panel_container.add_child(menu_button)

func get_menu_button():
	return get_child(0).get_child(0)

func get_menu_popup():
	return get_menu_button().get_popup()

#func add_item(label:String = "", id:int = -1):
#	get_menu_popup().add_item(label,id)
#
#func add_separator(label:String = ""):
#	get_menu_popup().add_separator(label)

func _on_menu_id_pressed(id:int):
	get_menu_button().text = get_menu_popup().get_item_text(id)
