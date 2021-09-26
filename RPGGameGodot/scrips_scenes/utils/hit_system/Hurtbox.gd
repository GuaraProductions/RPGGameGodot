extends Area2D

var invincible = false setget set_invincible

export(float) var invincibility_duration = 0

onready var timer = $Timer

signal is_invincible
signal not_invincible

func set_invincible(value):
	invincible = value
	if invincible:
		emit_signal("is_invincible")
	else:
		emit_signal("not_invincible")

func start_invincibility():
	self.invincible = true
	timer.start(self.invincibility_duration)

func _on_Timer_timeout():
	self.invincible = false


func _on_Area2D_is_invincible():
	set_deferred("monitorable", false)


func _on_Area2D_not_invincible():
	self.monitorable = true
