extends SFXGenNode
class_name SFXGenOscillatorNode

var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var slot2:HBoxContainer = null

func _init():
	slot0 = add_slot_control(-1,-1)
	slot1 = add_slot_control(-1,-1)
	slot2 = add_slot_control(-1,-1)
