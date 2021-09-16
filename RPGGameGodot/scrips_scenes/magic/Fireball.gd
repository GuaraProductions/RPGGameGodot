extends Node2D

var motion         = Vector2.ZERO
onready var hitbox = $Hitbox

func _ready():
	hitbox.knockback_vector = Vector2.RIGHT
	
func init(speed,pos):
	self.motion = speed
	self.set_position(pos)
	self.rotate(speed.angle())
	
	$Hitbox.knockback_vector = motion 

func _process(delta):
	translate(motion * delta)

func _on_Timer_timeout():
	queue_free()
