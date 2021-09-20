extends Node2D

var motion         = Vector2.ZERO

func init(speed,pos):
	self.motion = speed
	self.set_position(pos)
	self.rotate(speed.angle())
	
	$Hitbox.knockback_vector = motion.normalized()

func _process(delta):
	translate(motion * delta)

func _on_Timer_timeout():
	queue_free()
