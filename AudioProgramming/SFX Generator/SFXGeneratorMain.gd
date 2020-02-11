extends Control

var undo_redo:UndoRedo = null
var root:VBoxContainer = null
var project_tabs:Tabs = null
var current_project_editor:GraphEdit = null
var add_node_popup_menu:PopupMenu = null
var no_projects_vbox:VBoxContainer = null

func add_node(id:int):
	# id should be value from NODE_TYPE_* enum
	# adds a node to the current_project_editor
	var node:GraphNode = null
	match id:
		Globals.NODE_TYPE_OSCILLATOR:
			node = SFXGenOscillatorNode.new()
		Globals.NODE_TYPE_4POLE_FILTER:
			node = SFXGen4PoleFilter.new()
		Globals.NODE_TYPE_ENVELOPE:
			node = SFXGenEnvelopeNode.new()
		Globals.NODE_TYPE_AUDIO_OUTPUT:
			node = SFXGenAudioOutputNode.new()
		Globals.NODE_TYPE_MATH:
			node = SFXGenMathNode.new()
		Globals.NODE_TYPE_BOOL:
			node = SFXGenBooleanNode.new()
		Globals.NODE_TYPE_INT:
			node = SFXGenIntegerNode.new()
		Globals.NODE_TYPE_REAL:
			node = SFXGenFloatNode.new()
		Globals.NODE_TYPE_STRING:
			node = SFXGenStringNode.new()
		Globals.NODE_TYPE_VECTOR2:
			node = SFXGenBooleanNode.new()
		Globals.NODE_TYPE_VECTOR3:
			node = SFXGenBooleanNode.new()
	node.offset = get_global_mouse_position() - current_project_editor.rect_global_position + current_project_editor.scroll_offset
	current_project_editor.add_child(node)

func delete_nodes():
	var node_list = current_project_editor.get_children()
	for node in node_list:
		if (node is GraphNode and node.selected):
			node.queue_free()

func add_project():
	# if project exists already
	if (current_project_editor != null):
	#	hide current_project_editor
		current_project_editor.visible = false
	
	# create new current_project_editor
	current_project_editor = SFXGenEditor.new()
	current_project_editor.name = "Unnamed Project " + str(project_tabs.get_tab_count() + 1)
	current_project_editor.connect("popup_request",self,"_on_project_editor_popup_request")
	current_project_editor.connect("delete_nodes_request",self,"_on_project_editor_delete_nodes_request")
	root.add_child(current_project_editor, true)
	
	# create new tab in project_tabs with project name
	project_tabs.add_tab(current_project_editor.name)
	project_tabs.current_tab = project_tabs.get_tab_count()-1
	
	if (no_projects_vbox.visible):
		no_projects_vbox.visible = false

func get_project_by_name(name:String):
	var projects = root.get_children()
	for project in projects:
		if (not project is GraphEdit):
			continue
		if (project.name == name):
			return project
	
	# no project found with this name
	return null

func close_project(name:String):
	get_project_by_name(name).queue_free()

func close_project_tab(tab:int):
	var name = project_tabs.get_tab_title(tab)
	close_project(name)
	project_tabs.remove_tab(tab)
	
	if (project_tabs.current_tab > -1):
		change_project_tab(project_tabs.current_tab)
	else:
		current_project_editor = null
		no_projects_vbox.visible = true

func change_project_tab(tab:int):
	current_project_editor.visible = false
	var name = project_tabs.get_tab_title(tab)
	current_project_editor = get_project_by_name(name)
	current_project_editor.visible = true

func _init():
	undo_redo = UndoRedo.new()

func _ready():
	project_tabs = $RootVBoxContainer/Tabs
	add_node_popup_menu = $AddNodePopupMenu
	root = $RootVBoxContainer
	no_projects_vbox = $RootVBoxContainer/NoProjectsVBox

func _on_project_editor_popup_request(position:Vector2):
	add_node_popup_menu.rect_position = position
	add_node_popup_menu.show_modal()

func _on_project_editor_delete_nodes_request():
	undo_redo.create_action("Delete Nodes")
	undo_redo.add_do_method(self,"delete_nodes")
	undo_redo.add_undo_method(self,"add_node",0)
	undo_redo.commit_action()

func _on_AddNodePopupMenu_id_pressed(id:int):
	add_node(id)

func _on_FileMenuButton_new_project_requested():
	add_project()

func _on_Tabs_tab_changed(tab:int):
	change_project_tab(tab)

func _on_Tabs_tab_close(tab:int):
	close_project_tab(tab)

func _on_NoProjectsVBox_Button_pressed():
	add_project()

func _on_FileMenuButton_close_project_requested():
	if (!no_projects_vbox.visible):
		close_project_tab(project_tabs.current_tab)


func _on_EditMenuButton_undo_requested():
	if (undo_redo.has_undo()):
		undo_redo.undo()
		print("UNDO")
	else:
		print("NO UNDO")


func _on_EditMenuButton_redo_requested():
	if (undo_redo.has_redo()):
		undo_redo.redo()
