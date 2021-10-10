extends Node

var num_active_quests setget set_num_of_active_quests, get_num_of_active_quests  
var num_completed_quests setget set_num_of_completed_quests, get_num_of_completed_quests  

signal new_quest_added(quest_name,quest_description)
signal quest_completed(quest_name,reward)

var active_quests : Dictionary
var completed_quests : Dictionary

func _ready():
	pass

func set_num_of_active_quests(_value):
	pass

func get_num_of_active_quests():
	return active_quests.size() 
	
func set_num_of_completed_quests(_value):
	pass

func get_num_of_completed_quests():
	return completed_quests.size() 

func get_active_quest_data(quest_name):
	return active_quests[quest_name]	
	
func get_completed_quest_data(quest_name):
	return completed_quests[quest_name]	

func add_quest(quest):
	active_quests[quest["name"]] = quest
	emit_signal("new_quest_added", quest["name"],quest["description"])
	
func mark_quest_as_completed(quest_name):
	
	if active_quests.has(quest_name):
		
		var completed_quest = active_quests.get(quest_name)
		active_quests.erase(quest_name)
		
		completed_quests[quest_name] = completed_quest
		
		emit_signal("quest_completed",quest_name,completed_quest["reward"])
		
		
	
