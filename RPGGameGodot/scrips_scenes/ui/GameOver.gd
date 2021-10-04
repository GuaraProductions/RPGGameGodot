extends Control

onready var animation   = $MenuAnimation
onready var main_button = $"VBoxContainer/CenterContainer2/VBoxContainer/Main Menu"
onready var quit_button = $"VBoxContainer/CenterContainer2/VBoxContainer/Quit"

func _ready():
	self.visible = false
	main_button.disabled = true
	quit_button.disabled = true
	
func start():
	self.visible = true
	animation.play("GameOver")

func on_game_over_animation_ended():
	main_button.disabled = false
	quit_button.disabled = false

func _on_Main_Menu_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
