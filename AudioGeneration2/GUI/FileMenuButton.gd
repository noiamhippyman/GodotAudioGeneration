extends MenuButton
class_name FileMenuButton

signal new_project_requested
signal close_project_requested

const FILE_NEW_PROJECT:int = 0
const FILE_CLOSE_PROJECT:int = 1

var popup:PopupMenu = null

func _ready():
	text = "File"
	
	popup = get_popup()
	popup.add_item("New Project", FILE_NEW_PROJECT)
	popup.add_item("Close Project", FILE_CLOSE_PROJECT)
	popup.connect("id_pressed", self, "_on_id_pressed")

func _on_id_pressed(id:int):
	match id:
		FILE_NEW_PROJECT:
			emit_signal("new_project_requested")
		FILE_CLOSE_PROJECT:
			emit_signal("close_project_requested")
