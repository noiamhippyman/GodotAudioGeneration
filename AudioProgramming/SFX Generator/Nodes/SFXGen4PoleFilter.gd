extends SFXGenNode
class_name SFXGen4PoleFilter

var filter:FilterResonant = null
var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var slot2:HBoxContainer = null
var slot3:HBoxContainer = null

func _init():
	title = "4-Pole Filter"
	
	slot0 = add_slot_control(Globals.SLOT_TYPE_REAL,Globals.SLOT_TYPE_REAL)
	slot1 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	slot2 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	slot3 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	
	filter = FilterResonant.new()
	add_child(filter)
	
	var filter_mode_label:Label = Label.new()
	filter_mode_label.text = "Filter Mode"
	filter_mode_label.align = Label.ALIGN_RIGHT
	slot0.add_child(filter_mode_label)
	
	var filter_mode_option_button:OptionButton = OptionButton.new()
	filter_mode_option_button.size_flags_horizontal = SIZE_EXPAND_FILL
	filter_mode_option_button.add_item("Lowpass",FilterResonant.eFilterMode.Lowpass)
	filter_mode_option_button.add_item("Highpass",FilterResonant.eFilterMode.Highpass)
	filter_mode_option_button.add_item("Bandpass",FilterResonant.eFilterMode.Bandpass)
	filter_mode_option_button.connect("item_selected",self,"_on_filter_mode_option_button_item_selected")
	slot0.add_child(filter_mode_option_button)
	
	var output_label:Label = Label.new()
	output_label.text = "Sample"
	output_label.align = Label.ALIGN_RIGHT
	add_spacer_to_slot_control(0)
	slot0.add_child(output_label)
	
	var cutoff_label:Label = Label.new()
	cutoff_label.text = "Cutoff"
	cutoff_label.align = Label.ALIGN_RIGHT
	slot1.add_child(cutoff_label)
	
	var cutoff_line:LineEdit = LineEdit.new()
	cutoff_line.size_flags_horizontal = SIZE_EXPAND_FILL
	slot1.add_child(cutoff_line)
	add_spacer_to_slot_control(1)
	
	var cutoff_mod_label:Label = Label.new()
	cutoff_mod_label.text = "Cutoff Mod"
	cutoff_mod_label.align = Label.ALIGN_RIGHT
	slot2.add_child(cutoff_mod_label)
	
	var cutoff_mod_slider:HSlider = HSlider.new()
	cutoff_mod_slider.size_flags_horizontal = SIZE_EXPAND_FILL
	slot2.add_child(cutoff_mod_slider)
	
	var resonance_label:Label = Label.new()
	resonance_label.text = "Resonance"
	resonance_label.align = Label.ALIGN_RIGHT
	slot3.add_child(resonance_label)
	
	var resonance_slider:HSlider = HSlider.new()
	resonance_slider.size_flags_horizontal = SIZE_EXPAND_FILL
	slot3.add_child(resonance_slider)

func _on_filter_mode_option_button_item_selected(id:int):
	filter.mode = id
