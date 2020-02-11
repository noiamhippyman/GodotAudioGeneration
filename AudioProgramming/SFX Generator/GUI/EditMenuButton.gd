extends MenuButton

var popup:PopupMenu = null

signal undo_requested
signal redo_requested

func _ready():
	popup = get_popup()
	popup.add_item("Undo", Globals.EDIT_UNDO)
	popup.add_item("Redo", Globals.EDIT_REDO)
	popup.connect("id_pressed", self, "_on_id_pressed")

func _on_id_pressed(id:int):
	match id:
		Globals.EDIT_UNDO:
			emit_signal("undo_requested")
		Globals.EDIT_REDO:
			emit_signal("redo_requested")
