extends StaticBody2D

var groupName = 'interactable_npc'
onready var sprites = $AnimatedSprite
onready var speech_bubble = $"Speech Bubble"

func _ready():
	speech_bubble.visible = false

func _on_InteractionZone_body_entered(_body):
	self.add_to_group(groupName)
	speech_bubble.visible = true

func _on_InteractionZone_body_exited(_body):
	self.remove_from_group(groupName)
	speech_bubble.visible = false
	
func interact_with_player(player_x,player_y):
	face_the_player(player_x,player_y)
	
func face_the_player(player_x,player_y):
	var curr_direction = Vector2(player_x - self.position.x, self.position.y - player_y).normalized()
	print(curr_direction)
	
	if(curr_direction.y < -0.5):
		sprites.set_frame(0)
		
	elif(curr_direction.y > -0.5 && curr_direction.y < 0.5):
		if(curr_direction.x < 0):
			sprites.set_frame(1)
		else:
			sprites.set_frame(2)
			
	else:
		sprites.set_frame(3)
	
