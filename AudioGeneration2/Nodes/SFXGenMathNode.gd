extends SFXGenNode
class_name SFXGenMathNode

func _init():
	var slot0:Control = add_slot(SFXGenNode.eSlotType.In,SFXGenNode.eSlotDataType.Value)
	slot0.set_slider_clamp(true)
	slot0.set_step(0.001)
	slot0.set_min_value(0.0)
	slot0.set_max_value(1.0)
	
	var slot1:Control = add_slot(SFXGenNode.eSlotType.In,SFXGenNode.eSlotDataType.Value)
