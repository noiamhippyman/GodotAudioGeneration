extends GraphNode
class_name OscillatorNode

var oscillator:Oscillator = null
var slot0:HBoxContainer = null
var slot1:HBoxContainer = null
var slot2:HBoxContainer = null
var wavetype_label:Label = null
var wavetype_option_button:OptionButton = null
var frequency_label:Label = null
var frequency_line_edit:LineEdit = null
var amplitude_label:Label = null
var amplitude_line_edit:LineEdit = null
var output_label:Label = null

func get_class():
	return "OscillatorNode"

func _init():
	title = "Oscillator"
	
	slot0 = HBoxContainer.new()
	slot1 = HBoxContainer.new()
	slot2 = HBoxContainer.new()
	add_child(slot0)
	add_child(slot1)
	add_child(slot2)
	
	wavetype_label = Label.new()
	wavetype_label.text = "Wave Type"
	wavetype_option_button = OptionButton.new()
	wavetype_option_button.add_item("0. Sine",Oscillator.eWaveType.Sine)
	wavetype_option_button.add_item("1. Square",Oscillator.eWaveType.Square)
	wavetype_option_button.add_item("2. Sawtooth",Oscillator.eWaveType.Sawtooth)
	wavetype_option_button.add_item("3. Triangle",Oscillator.eWaveType.Triangle)
	wavetype_option_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wavetype_option_button.connect("item_selected",self,"_on_wavetype_selected")
	
	var spacer_control = Control.new()
	spacer_control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	output_label = Label.new()
	output_label.text = "Output"
	output_label.align = Label.ALIGN_RIGHT
	
	slot0.add_child(wavetype_label)
	slot0.add_child(wavetype_option_button)
	slot0.add_child(spacer_control)
	slot0.add_child(output_label)
	
	frequency_label = Label.new()
	frequency_label.text = "Frequency"
	
	frequency_line_edit = LineEdit.new()
	frequency_line_edit.text = "440.0"
	frequency_line_edit.placeholder_text = "440.0"
	frequency_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	frequency_line_edit.connect("text_entered",self,"_on_frequency_changed")
	
	spacer_control = Control.new()
	spacer_control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	slot1.add_child(frequency_label)
	slot1.add_child(frequency_line_edit)
	slot1.add_child(spacer_control)

	amplitude_label = Label.new()
	amplitude_label.text = "Amplitude"
	
	amplitude_line_edit = LineEdit.new()
	amplitude_line_edit.text = "0.5"
	amplitude_line_edit.placeholder_text = "0.5"
	amplitude_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	amplitude_line_edit.connect("text_entered",self,"_on_amplitude_changed")
	
	spacer_control = Control.new()
	spacer_control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	slot2.add_child(amplitude_label)
	slot2.add_child(amplitude_line_edit)
	slot2.add_child(spacer_control)
	
	set_slot(0,true,Globals.SLOT_TYPE_INT,Globals.SLOT_COLOR_INT,true,Globals.SLOT_TYPE_REAL,Globals.SLOT_COLOR_REAL)
	set_slot(1,true,Globals.SLOT_TYPE_REAL,Globals.SLOT_COLOR_REAL,false,-1,-1)
	set_slot(2,true,Globals.SLOT_TYPE_REAL,Globals.SLOT_COLOR_REAL,false,-1,-1)
	
	oscillator = Oscillator.new()
	oscillator.wave_type = Oscillator.eWaveType.Sine
	add_child(oscillator)

func _on_wavetype_selected(id:int):
	oscillator.wave_type = id

func _on_frequency_changed(value:String):
	if (value.is_valid_float()):
		oscillator.frequency = float(value)
	else:
		frequency_line_edit.text = frequency_line_edit.placeholder_text

func _on_amplitude_changed(value:String):
	if (value.is_valid_float()):
		oscillator.peak_amplitude = clamp(float(value),0.0,1.0)
		amplitude_line_edit.text = str(oscillator.peak_amplitude)
	else:
		amplitude_line_edit.text = amplitude_line_edit.placeholder_text
