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
	
	if event.is_action_released("pause"):
		
		pause_game()
		
		pauseMenu.visible = get_tree().paused
		
	elif event.is_action_released("quest"):
		
		pause_game()
		
		questMenu.visible = not questMenu.visible
		
func pause_game():
	get_tree().paused = not get_tree().paused
	statsBars.visible = not get_tree().paused	

func _on_PauseMenu_exit_pause():
	get_tree().paused = false
	pauseMenu.visible = false
	
func player_died():
	statsBars.visible = false
	gameOver.start()
