extends MenuButton

var popup:PopupMenu = null

signal new_project_requested
signal close_project_requested

func _ready():
	popup = get_popup()
	popup.add_item("New Project", Globals.FILE_NEW_PROJECT)
	popup.add_item("Close Project", Globals.FILE_CLOSE_PROJECT)
	popup.connect("id_pressed", self, "_on_id_pressed")

func _on_id_pressed(id:int):
	match id:
		Globals.FILE_NEW_PROJECT:
			emit_signal("new_project_requested")
		Globals.FILE_CLOSE_PROJECT:
			emit_signal("close_project_requested")
