extends SFXGenNode
class_name SFXGenEnvelopeNode

var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var slot2:HBoxContainer = null
var slot3:HBoxContainer = null

var envelope:EnvelopeADSR = null

func _init():
	
	title = "Envelope"
	
	slot0 = add_slot_control(Globals.SLOT_TYPE_REAL, Globals.SLOT_TYPE_REAL)
	slot1 = add_slot_control(Globals.SLOT_TYPE_REAL, -1)
	slot2 = add_slot_control(Globals.SLOT_TYPE_REAL, -1)
	slot3 = add_slot_control(Globals.SLOT_TYPE_REAL, -1)
	
	envelope = EnvelopeADSR.new()
	add_child(envelope)
	
	var attack_label:Label = Label.new()
	attack_label.text = "Attack"
	attack_label.align = Label.ALIGN_RIGHT
	slot0.add_child(attack_label)
	
	var attack_line:LineEdit = LineEdit.new()
	attack_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot0.add_child(attack_line)
	
	var output_label:Label = Label.new()
	output_label.text = "Sample"
	output_label.align = Label.ALIGN_RIGHT
	add_spacer_to_slot_control(0)
	slot0.add_child(output_label)
	
	var decay_label:Label = Label.new()
	decay_label.text = "Decay"
	decay_label.align = Label.ALIGN_RIGHT
	slot1.add_child(decay_label)
	
	var decay_line:LineEdit = LineEdit.new()
	decay_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot1.add_child(decay_line)
	add_spacer_to_slot_control(1)
	
	var sustain_label:Label = Label.new()
	sustain_label.text = "Sustain"
	sustain_label.align = Label.ALIGN_RIGHT
	slot2.add_child(sustain_label)
	
	var sustain_line:LineEdit = LineEdit.new()
	sustain_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot2.add_child(sustain_line)
	add_spacer_to_slot_control(2)
	
	var release_label:Label = Label.new()
	release_label.text = "Release"
	release_label.align = Label.ALIGN_RIGHT
	slot3.add_child(release_label)
	
	var release_line:LineEdit = LineEdit.new()
	release_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot3.add_child(release_line)
	add_spacer_to_slot_control(3)
