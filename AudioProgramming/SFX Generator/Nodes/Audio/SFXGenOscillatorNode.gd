extends SFXGenNode
class_name SFXGenOscillatorNode

var oscillator:Oscillator = null
var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var slot2:HBoxContainer = null
var slot3:HBoxContainer = null

func _init():
	title = "Oscillator"
	
	slot0 = add_slot_control(-1,Globals.SLOT_TYPE_REAL)
	slot0.alignment = HBoxContainer.ALIGN_END
	slot1 = add_slot_control(-1,-1)
	slot2 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	slot3 = add_slot_control(Globals.SLOT_TYPE_REAL,-1)
	
	oscillator = Oscillator.new()
	add_child(oscillator)
	
	var wavetype_label:Label = Label.new()
	wavetype_label.text = "Wave Type"
	wavetype_label.align = Label.ALIGN_RIGHT
	slot1.add_child(wavetype_label)
	
	var wavetype_option_button:OptionButton = OptionButton.new()
	wavetype_option_button.size_flags_horizontal = SIZE_EXPAND_FILL
	wavetype_option_button.add_item("Sine",Oscillator.eWaveType.Sine)
	wavetype_option_button.add_item("Square",Oscillator.eWaveType.Square)
	wavetype_option_button.add_item("Sawtooth",Oscillator.eWaveType.Sawtooth)
	wavetype_option_button.add_item("Triangle",Oscillator.eWaveType.Triangle)
	wavetype_option_button.connect("item_selected",self,"_on_wavetype_option_button_item_selected")
	slot1.add_child(wavetype_option_button)
	
	var output_label:Label = Label.new()
	output_label.text = "Sample"
	output_label.align = Label.ALIGN_RIGHT
	slot0.add_child(output_label)
	
	var frequency_label:Label = Label.new()
	frequency_label.text = "Frequency"
	frequency_label.align = Label.ALIGN_RIGHT
	slot2.add_child(frequency_label)
	
	#var frequency_line:LineEdit = LineEdit.new()
	#frequency_line.size_flags_horizontal = SIZE_EXPAND_FILL
	#slot2.add_child(frequency_line)
	#add_spacer_to_slot_control(2)
	
	var amplitude_label:Label = Label.new()
	amplitude_label.text = "Amplitude"
	amplitude_label.align = Label.ALIGN_RIGHT
	slot3.add_child(amplitude_label)
	
	#var amplitude_line:LineEdit = LineEdit.new()
	#amplitude_line.size_flags_horizontal = SIZE_EXPAND_FILL
	#slot3.add_child(amplitude_line)
	#add_spacer_to_slot_control(3)

func _on_wavetype_option_button_item_selected(id:int):
	oscillator.wave_type = id
