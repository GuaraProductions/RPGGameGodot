extends Control

var quests = QuestManager
onready var questItems = $"QuestItems/AllQuests"

func _ready():
	questItems.is_anything_selected()

