extends Node2D

var motion = Vector2.ZERO

func _ready():
	pass
	
func init(speed,pos):
	self.motion = speed
	self.set_position(pos)
	self.rotate(speed.angle())

func _process(delta):
	translate(motion * delta)

func _on_Timer_timeout():
	queue_free()
