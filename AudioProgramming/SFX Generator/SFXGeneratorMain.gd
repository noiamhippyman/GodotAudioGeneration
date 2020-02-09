extends Control

var root:VBoxContainer = null
var project_tabs:Tabs = null
var current_project_editor:GraphEdit = null
var add_node_popup_menu:PopupMenu = null

func add_node(id:int):
	var node:GraphNode = null
	match id:
		Globals.NODE_TYPE_OSCILLATOR:
			node = OscillatorNode.new()
		Globals.NODE_TYPE_AUDIO_OUTPUT:
			node = AudioOutputNode.new()
	node.offset = get_global_mouse_position() - current_project_editor.rect_global_position + current_project_editor.scroll_offset
	current_project_editor.add_child(node)

func add_project():
	# if project exists already
	if (current_project_editor != null):
	#	hide current_project_editor
		current_project_editor.visible = false
	
	# create new current_project_editor
	current_project_editor = GraphEdit.new()
	current_project_editor.name = "Unnamed Project " + str(project_tabs.get_tab_count() + 1)
	current_project_editor.size_flags_horizontal = SIZE_EXPAND_FILL
	current_project_editor.size_flags_vertical = SIZE_EXPAND_FILL
	current_project_editor.connect("popup_request",self,"_on_GraphEdit_popup_request")
	root.add_child(current_project_editor, true)
	
	# create new tab in project_tabs with project name
	project_tabs.add_tab(current_project_editor.name)
	project_tabs.current_tab = project_tabs.get_tab_count()-1
	
	print(root.get_children())

func close_project(name:String):
	var existing_projects = root.get_children()
	var current_project = null
	for project in existing_projects:
		if (project.name == name):
			project.queue_free()
			break

func change_project_tab(tab:int):
	current_project_editor.visible = false
	var name = project_tabs.get_tab_title(tab)
	var existing_projects = root.get_children()
	for child in existing_projects:
		if (child.name == name):
			current_project_editor = child
			current_project_editor.visible = true
			print(current_project_editor.name)
			break

func _ready():
	project_tabs = $RootVBoxContainer/Tabs
	add_node_popup_menu = $AddNodePopupMenu
	root = $RootVBoxContainer
	
	add_project()

func _on_GraphEdit_popup_request(position:Vector2):
	add_node_popup_menu.rect_position = position
	add_node_popup_menu.show_modal()
	print(position)

func _on_AddNodePopupMenu_id_pressed(id:int):
	add_node(id)

func _on_FileMenuButton_new_project_requested():
	add_project()

func _on_Tabs_tab_changed(tab:int):
	change_project_tab(tab)

func _on_Tabs_tab_close(tab:int):
	var name = project_tabs.get_tab_title(tab)
	close_project(name)
	project_tabs.remove_tab(tab)
	
	if (project_tabs.current_tab > -1):
		change_project_tab(project_tabs.current_tab)
	else:
		current_project_editor = null
