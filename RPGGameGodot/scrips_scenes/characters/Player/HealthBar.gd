extends "res://scrips_scenes/utils/stats/StatsBar.gd"

var player_stats = PlayerStats

func _ready():
	var health      = player_stats.health
	value_bar.value = health
	player_stats.connect("health_changed", self, "on_value_updated")
	update_label(health)
	on_max_value_updated(player_stats.max_health)

