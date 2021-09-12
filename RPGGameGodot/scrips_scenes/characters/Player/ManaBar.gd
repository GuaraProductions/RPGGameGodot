extends "res://scrips_scenes/utils/stats/StatsBar.gd"

var player_stats = PlayerStats

func _ready():
	var mana        = player_stats.mana
	value_bar.value = mana
	player_stats.connect("mana_changed", self, "on_value_updated")
	update_label(mana)
	on_max_value_updated(player_stats.max_mana)
