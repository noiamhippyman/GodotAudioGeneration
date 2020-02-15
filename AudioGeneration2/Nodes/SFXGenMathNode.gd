extends SFXGenNode
class_name SFXGenMathNode

var s0 = null
var s1:SFXGenNodeSliderSlot = null
var s2:SFXGenNodeSliderSlot = null
var s3:SFXGenNodeMenuSlot = null

func _init():

	s0 = add_slot_output("Value")
	s1 = add_slot_slider("A",false)
	s2 = add_slot_slider("B",false)
	
	var menu_options = ["Add","Subtract","Multiply","Divide"]
	s3 = add_slot_menu(menu_options)
