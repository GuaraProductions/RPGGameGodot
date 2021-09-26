extends Control

onready var player_bars = $"../PlayerStatsBars"

var playerStats = PlayerStats

func _ready():
	self.visible = false
	playerStats.connect("no_health",self,"game_over")
	
func game_over():
	self.visible = true
	player_bars.visible = false


func _on_Main_Menu_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
