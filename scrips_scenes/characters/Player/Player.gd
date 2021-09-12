extends KinematicBody2D

export(PackedScene) var fireball

var speed_vector      = Vector2.ZERO 
var prev_speed        = Vector2(0,-150) 
var interactable_body = null

export var MAX_SPEED = 150

enum {
	MOVE,
	ATTACK,
}

var curr_state;
var stats = PlayerStats

onready var animation            = $AnimationPlayer
onready var all_animations       = $AnimationTree
onready var animationState       = all_animations.get("parameters/playback")
onready var interactionRect      = $"InteractionZone/InteractionRect"

func _ready():
	stats.connect("no_health", self, "queue_free")
	curr_state = MOVE

func _process(delta):
	
	match(curr_state):
		MOVE:
			move_state(delta)  
		
		ATTACK:
			attack_state(delta)
			
	player_actions()
	
func move_state(delta):
	
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")  - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		all_animations.set("parameters/Idle/blend_position", input_vector)
		all_animations.set("parameters/Walking/blend_position", input_vector)
		all_animations.set("parameters/Attacking/blend_position", input_vector)
		animationState.travel("Walking")
		speed_vector = input_vector * MAX_SPEED
		prev_speed = speed_vector
	
	else:
		animationState.travel("Idle")
		speed_vector = Vector2.ZERO
	
	move_and_collide(speed_vector * delta)

func attack_state(delta):
	speed_vector = Vector2.ZERO
	animationState.travel("Attacking")
	
func end_attack_state():
	curr_state = MOVE
	
func create_fireball(pos):
	
	if stats.mana < 30:
		return 
	
	stats.reduce_mana(30)
	var projectile = fireball.instance()
	projectile.init(prev_speed,pos)
	get_tree().get_root().add_child(projectile)
	
	
func player_actions():	
	if Input.is_action_just_pressed("attack"):
		create_fireball(interactionRect.global_position)
		curr_state = ATTACK
	elif Input.is_action_just_pressed("interact"):
		if(interactable_body != null):
			interactable_body.interact(self.position.x, self.position.y)


func _on_InteractionZone_body_entered(body):
	interactable_body = body

func _on_InteractionZone_body_exited(_body):
	interactable_body = null
