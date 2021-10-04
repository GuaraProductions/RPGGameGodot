extends Node

var num_active_quests setget set_num_of_active_quests, get_num_of_active_quests  
var num_completed_quests setget set_num_of_completed_quests, get_num_of_completed_quests  

signal new_quest_added(quest_name)
signal quest_completed(quest_name,reward)

var quests : Dictionary = {
	"ActiveQuests" : { "questName" : {}},
	"CompletedQuests" : { "questName" : {}},
}

func _ready():
	pass

func set_num_of_active_quests(_value):
	pass

func get_num_of_active_quests():
	return quests["ActiveQuests"].size() - 1
	
func set_num_of_completed_quests(_value):
	pass

func get_num_of_completed_quests():
	return quests["CompletedQuests"].size() - 1

func get_quest_data(quest_name):
	return quests["ActiveQuests"][quest_name]	

func add_quest(quest_name):
	pass
	
func mark_quest_as_completed(quest_name):
	
	if quests["CompletedQuests"].has(quest_name):
		
		var completedQuest = quests["CompletedQuests"].get(quest_name)
		quests["CompletedQuests"].erase(quest_name)
		
		
	
