extends Control

var quests = QuestManager

onready var quest_items            = $"QuestItems/AllQuests"
onready var curr_quest_description = $"QuestDescriptionBox/DetailsBox/QuestDetails"
onready var no_quest_text          = $"QuestItems/No quest"

onready var quest_switcher = $"CenterContainer/QuestsSwitcher"

var selected_quest : int
var no_available_quest : bool

var quest_types
var quest_type_index

func _ready():
	
	quests.connect("new_quest_added",self,"add_quest_log")
	
	no_available_quest = true
	
	selected_quest   = -1
	quest_type_index = 0
	
	quest_types         = ["Active Quests", "Completed Quests"]
	quest_switcher.text = quest_types[quest_type_index]
	
	no_quest_text.visible = true
	
func add_quest_log(quest_name,quest_description):
	quest_items.add_item(quest_name)

func _on_QuestsSwitcher_pressed():
	quest_type_index += 1
	
	if quest_type_index > quest_types.size() - 1:
		quest_type_index = 0; 
		
	quest_switcher.text = quest_types[quest_type_index]
