extends Control

signal exit_pause

func _ready():
	self.visible = false

func _on_Quit_pressed():
	get_tree().quit()

func _on_Resume_pressed():
	emit_signal("exit_pause")
