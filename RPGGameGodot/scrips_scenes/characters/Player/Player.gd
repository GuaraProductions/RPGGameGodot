extends KinematicBody2D

export(PackedScene) var fireball

var speed_vector      = Vector2.ZERO 
var prev_speed        = Vector2(0,-150) 
var interactable_body = null

enum {
	MOVE,
	ATTACK,
	INTERACT,
}

var curr_state;
var stats = PlayerStats
var dialog = Dialogic

onready var animation       = $AnimationPlayer
onready var all_animations  = $AnimationTree
onready var animationState  = all_animations.get("parameters/playback")
onready var interactionRect = $"InteractionZone/InteractionRect"
onready var swordHitbox     = $"HitboxPivot/SwordHitbox"
onready var hurtbox         = $Hurtbox

func _ready():
	stats.connect("no_health", self, "queue_free")
	curr_state = MOVE
	
	stats.defense = 0
	
	swordHitbox.knockback_vector = Vector2.ZERO

func _process(delta):
	
	match(curr_state):
		MOVE:
			move_state(delta)  
		
		ATTACK:
			attack_state(delta)
			
		INTERACT:
			interact_state()
	
	if curr_state != INTERACT:		
		player_actions()
	
func move_state(delta):
	
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down")  - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		swordHitbox.knockback_vector = input_vector
		
		all_animations.set("parameters/Idle/blend_position", input_vector)
		all_animations.set("parameters/Walking/blend_position", input_vector)
		all_animations.set("parameters/Attacking/blend_position", input_vector)
		animationState.travel("Walking")
		speed_vector = input_vector * stats.speed
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
	
func end_interact_state(_timeline_name):
	curr_state = MOVE
	if interactable_body != null:
		interactable_body.after_dialog_end()
	
func interact_state():
	pass
	
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
			print("cheguei aq")
			curr_state = INTERACT
			var conversation_name = interactable_body.interact(self.position.x, self.position.y)
			animationState.travel("Idle")
			speed_vector = Vector2.ZERO
			
			if conversation_name != null:
				var new_dialog = dialog.start(conversation_name, false)
				add_child(new_dialog)
				new_dialog.connect("timeline_end", self, "end_interact_state")
			else:
				curr_state = MOVE
			
func _on_InteractionZone_body_entered(body):
	interactable_body = body

func _on_InteractionZone_body_exited(_body):
	interactable_body.after_dialog_end()
	interactable_body = null

func _on_Hurtbox_area_entered(area):
	stats.deal_damage(area.damage)
	hurtbox.start_invincibility()
	
