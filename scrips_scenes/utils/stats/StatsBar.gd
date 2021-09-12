extends Control

export(String) var label_sufix;

onready var value_bar    = $Bar
onready var value_tween  = $BarUnder
onready var update_tween = $Tween
onready var label        = $"LabelCentering/Label"

func on_value_updated(value):
	update_label(value)
	value_bar.value = value
	update_tween.interpolate_property(value_tween,
									 "value", 
									 value_tween.value, 
									 value, 
									 0.5, 
									 Tween.TRANS_SINE,
									 Tween.EASE_IN_OUT)
									
	update_tween.start()
	
func on_max_value_updated(max_value):
	value_tween.max_value = max_value
	value_bar.max_value   = max_value
	
func update_label(value):
	label.text = str(value) + " " + self.label_sufix
