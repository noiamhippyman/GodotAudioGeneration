extends SFXGenNode
class_name SFXGenMathNode

var s0:SFXGenNodeOutputSlot = null
var s1:SFXGenNodeSliderSlot = null
var s2:SFXGenNodeSliderSlot = null
var s3:SFXGenNodeMenuSlot = null

func _init():

	title = "Math"

	s0 = add_slot_output("Value")
	s1 = add_slot_slider("Value",false)
	s1.set_step(0.01)
	s2 = add_slot_slider("Value",false)
	s2.set_step(0.01)
	
	var menu_options = [
		"Add","Subtract","Multiply","Divide",
		"-","Power","Logarithm","Square Root","Absolute",
		"-","Minimum","Maximum","Greater Than","Less Than","Equal To",
		"-","Round","Ceil","Floor","Modulo",
		"-","Sine","Cosine","Tangent","Arcsine","Arccosine","Arctangent","Arctan2"]
	s3 = add_slot_menu(menu_options)
	s3.connect("menu_item_selected",self,"_on_menu_item_selected")

func slot_2_off():
	s2.visible = false
	set_slot(2,false,-1,-1,false,-1,-1)

func slot_2_on():
	s2.visible = true
	set_slot(2,true,0,Color.azure,false,-1,-1)

func _on_menu_item_selected(id:int):
	var func_text = s3.get_menu_popup().get_item_text(id)
	title = func_text
	match func_text:
		"Square Root":
			slot_2_off()
		"Absolute":
			slot_2_off()
		"Round":
			slot_2_off()
		"Ceil":
			slot_2_off()
		"Floor":
			slot_2_off()
		"Sine":
			slot_2_off()
		"Cosine":
			slot_2_off()
		"Tangent":
			slot_2_off()
		"Arcsine":
			slot_2_off()
		"Arccosine":
			slot_2_off()
		"Arctangent":
			slot_2_off()
		_:
			slot_2_on()
