extends StaticBody2D

onready var sprites = $AnimatedSprite
onready var speech_bubble = $"Speech Bubble"

var in_conversation : bool

func _ready():
	_speech_bubble_off()
	in_conversation = false
	
func interact(player_x,player_y):
	if !in_conversation:
		in_conversation = true
		face_the_player(player_x,player_y)
		var new_dialog = Dialogic.start('martha-first-conversation')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "after_dialog_end")
	
func after_dialog_end(timeline_name):
	in_conversation = false
	
func face_the_player(player_x,player_y):
	var curr_direction = Vector2(player_x - self.position.x, self.position.y - player_y).normalized()
	
	if(curr_direction.y < -0.5):
		sprites.set_frame(0)
		
	elif(curr_direction.y > -0.5 && curr_direction.y < 0.5):
		if(curr_direction.x < 0):
			sprites.set_frame(1)
		else:
			sprites.set_frame(2)
			
	else:
		sprites.set_frame(3)

func _on_InteractionZone_area_entered(area):
	_speech_bubble_on()

func _on_InteractionZone_area_exited(area):
	_speech_bubble_off()

func _speech_bubble_off():
	speech_bubble.visible = false
	speech_bubble.stop()
	speech_bubble.set_frame(0)
	
func _speech_bubble_on():
	speech_bubble.visible = true
	speech_bubble.play("default", false)
