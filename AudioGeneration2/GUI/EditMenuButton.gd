extends MenuButton
class_name EditMenuButton

signal undo_requested
signal redo_requested

const EDIT_UNDO:int = 0
const EDIT_REDO:int = 1

var popup:PopupMenu = null

func _ready():
	text = "Edit"
	
	popup = get_popup()
	popup.add_item("Undo", EDIT_UNDO)
	popup.add_item("Redo", EDIT_REDO)
	popup.connect("id_pressed", self, "_on_id_pressed")

func _on_id_pressed(id:int):
	match id:
		EDIT_UNDO:
			emit_signal("undo_requested")
		EDIT_REDO:
			emit_signal("redo_requested")
