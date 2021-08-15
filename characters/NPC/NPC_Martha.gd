extends StaticBody2D

var interactable

func _ready():
	interactable = false
	
func _process(delta):
	if(interactable && Input.is_action_just_pressed("ui_accept")):
		print('Interagiu caralho')


func _on_InteractionZone_body_entered(_body):
	print('Entrou caralho')
	interactable = true

func _on_InteractionZone_body_exited(_body):
	print('Vai embora seu gado')
	interactable = false
