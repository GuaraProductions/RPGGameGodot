extends KinematicBody2D

enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

export var ACCELERATION = 300
export var MAX_SPEED    = 50
export var FRICTION     = 200

onready var stats          = $Stats
onready var playerDetector = $PlayerDetection
onready var animations     = $AnimatedSprite

var curr_state

func _ready():
	curr_state = IDLE
	
	stats.max_health = 3
	stats.health     = 3
	
	stats.connect("no_health", self, "queue_free")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match curr_state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			_seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetector.player
			if player != null:
				var direction = (player.global_position - self.global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				curr_state = IDLE
				
			animations.flip_h = velocity.x > 0
			
	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * FRICTION/2
	
func _seek_player():
	if playerDetector.can_see_player():
		curr_state = CHASE
