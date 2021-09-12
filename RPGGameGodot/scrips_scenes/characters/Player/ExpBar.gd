extends "res://scrips_scenes/utils/stats/StatsBar.gd"

var player_stats = PlayerStats

func _ready():
	var experience    = player_stats.experience
	value_bar.value   = experience
	value_tween.value = 0
	player_stats.connect("exp_changed", self, "on_value_updated")
	update_label(experience)
	on_max_value_updated(player_stats.max_experience)
