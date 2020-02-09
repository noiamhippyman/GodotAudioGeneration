extends Control

var add_node_popup:PopupMenu = null
var graph_editor:GraphEdit = null
var selected_node:Node = null

func _ready():
	OS.low_processor_usage_mode = true
	graph_editor = $VBoxContainer/GraphEdit
	graph_editor.connect("node_selected",self,"_on_node_selected")
	add_node_popup = $AddNodePopupMenu
	add_node_popup.connect("id_pressed",self,"_on_add_node_type_selected")

func _input(event):
	if (event.is_action_pressed("kb_shortcut_add_node")):
		add_node_popup.show_modal()
		add_node_popup.rect_global_position = get_global_mouse_position()
	
	if (event.is_action_pressed("ui_accept")):
		generate()

func add_node(id:int):
	var node:GraphNode = null
	var node_offset = get_global_mouse_position() + graph_editor.scroll_offset
	
	match id:
		Globals.NODE_TYPE_OSCILLATOR:
			node = OscillatorNode.new()
		Globals.NODE_TYPE_AUDIO_OUTPUT:
			node = AudioOutputNode.new()
	
	node.offset = node_offset
	graph_editor.add_child(node)

func delete_node():
	if (selected_node):
		selected_node.queue_free()
		selected_node = null

func generate():
	var connection_list = graph_editor.get_connection_list()
	print(connection_list)

func _on_node_selected(node:Node):
	selected_node = node

func _on_add_node_type_selected(id):
	add_node(id)

func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	graph_editor.connect_node(from,from_slot,to,to_slot)

func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	graph_editor.disconnect_node(from,from_slot,to,to_slot)
