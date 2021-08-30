extends KinematicBody2D

var speed_vector = Vector2.ZERO 

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
		speed_vector = input_vector * MAX_SPEED;
	
	else:
		animationState.travel("Idle")
		speed_vector = Vector2.ZERO
	
	move_and_collide(speed_vector * delta)

func attack_state(delta):
	speed_vector = Vector2.ZERO
	animationState.travel("Attacking")
	
func end_attack_state():
	curr_state = MOVE
	
func player_actions():	
	if Input.is_action_just_pressed("attack"):
		curr_state = ATTACK
	elif Input.is_action_just_pressed("interact"):
		var npc = get_tree().get_nodes_in_group('interactable_npc')
		if(npc.size() > 0):
			npc[0].interact_with_player(self.position.x, self.position.y)
