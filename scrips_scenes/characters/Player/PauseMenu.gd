extends Control

onready var player_bars = $"../PlayerStatsBars"

func _ready():
	self.visible = false

func _input(event):
	
	if event.is_action_released("pause"):
		
		get_tree().paused = not get_tree().paused
		player_bars.visible = not get_tree().paused
		
		self.visible = get_tree().paused


func _on_Resume_pressed():
	get_tree().paused = false
	self.visible = false
	player_bars.visible = true

func _on_Exit_pressed():
	get_tree().quit()
