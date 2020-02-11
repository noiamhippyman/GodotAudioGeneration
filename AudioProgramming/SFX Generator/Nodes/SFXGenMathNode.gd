extends SFXGenNode
class_name SFXGenMathNode

var value_a:int
var value_b:int
var function_list_option_button:OptionButton = null

func _init():
	title = "Add"
	
	var slot0:HBoxContainer = add_slot_control(Globals.SLOT_TYPE_INT,Globals.SLOT_TYPE_INT)
	var slot1:HBoxContainer = add_slot_control(Globals.SLOT_TYPE_INT,-1)
	var slot2:HBoxContainer = add_slot_control(-1,-1)
	
	var value_a_line:LineEdit = LineEdit.new()
	slot0.add_child(value_a_line)
	
	var value_b_line:LineEdit = LineEdit.new()
	slot1.add_child(value_b_line)
	
	var output_label:Label = Label.new()
	output_label.text = "Value"
	slot0.add_child(output_label)
	
	function_list_option_button = OptionButton.new()
	function_list_option_button.add_item("Add")
	function_list_option_button.add_item("Subtract")
	function_list_option_button.add_item("Multiply")
	function_list_option_button.add_item("Divide")
	function_list_option_button.size_flags_horizontal = SIZE_EXPAND_FILL
	function_list_option_button.connect("item_selected",self,"_on_function_list_option_button_item_selected")
	slot2.add_child(function_list_option_button)

func _on_function_list_option_button_item_selected(id:int):
	title = function_list_option_button.get_item_text(id)
