extends Control

var graph_editor:GraphEdit = null
var selected_node:Node = null

func _on_node_selected(node:Node):
	selected_node = node

func _ready():
	OS.low_processor_usage_mode = true
	graph_editor = $VBoxContainer/GraphEdit
	graph_editor.connect("node_selected",self,"_on_node_selected")

func _on_AddNodeButton_pressed():
	var osc_node:OscillatorNode = OscillatorNode.new()
	graph_editor.add_child(osc_node)
	var audio_node:AudioOutputNode = AudioOutputNode.new()
	graph_editor.add_child(audio_node)


func _on_DeleteNodeButton_pressed():
	if (selected_node):
		selected_node.queue_free()
		selected_node = null
