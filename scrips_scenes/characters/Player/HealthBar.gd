extends Control

onready var health_bar   = $HealthBar
onready var health_tween = $HealthBarUnder
onready var update_tween = $Tween
onready var health_label = $CenterContainer/Label

var player_stats = PlayerStats

func _ready():
	health_bar.value = player_stats.health
	player_stats.connect("health_changed", self, "_on_health_updated")
	_update_health_label()
	_on_max_health_updated()

func _on_health_updated(health):
	_update_health_label()
	health_bar.value = player_stats.health
	update_tween.interpolate_property(health_tween, "value", health_tween.value, health, 0.05, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	
func _on_max_health_updated():
	health_tween.max_value = player_stats.max_health
	health_bar.max_value   = player_stats.max_health
	
func _update_health_label():
	health_label.text = str(player_stats.health) + "/" + str(player_stats.max_health)
