extends CanvasLayer

onready var statsBars = $PlayerStatsBars
onready var pauseMenu = $PauseMenu
onready var gameOver  = $GameOver
onready var questMenu = $QuestLog

var playerStats = PlayerStats

func _ready():
	playerStats.connect("no_health",self,"player_died")
	statsBars.visible = true

func _input(event):
	
	if event.is_action_released("pause") :
		
		if questMenu.visible:
			switch_visibility([pauseMenu,questMenu])
		else:
			switch_pause()
			switch_visibility([pauseMenu])
		
	elif event.is_action_released("quest"):
		
		if pauseMenu.visible:
			switch_visibility([pauseMenu,questMenu])
		else:
			switch_pause()
			switch_visibility([questMenu])
		

func switch_visibility(components):
	for comp in components:
		comp.visible = not comp.visible
		
func switch_pause():
	get_tree().paused = not get_tree().paused
	statsBars.visible = not get_tree().paused	

func _on_PauseMenu_exit_pause():
	get_tree().paused = false
	pauseMenu.visible = false
	
func player_died():
	statsBars.visible = false
	gameOver.start()
