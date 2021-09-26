extends Node

export(int) var max_health = 4          setget set_max_health
var health                 = max_health setget set_health
export var defense = 10

signal no_health
signal health_changed(health)
signal max_health_changed(value)

func deal_damage(damage):
	var damage_dealt = max(damage - defense,0)
	self.health -= damage_dealt

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed",max_health)

func set_health(value):
	var previous_health = health
	health = max(value,0)
	if previous_health != health:
		emit_signal("health_changed", value)
		
	if health <= 0:
		emit_signal("no_health")
		
func _ready():
	self.health = max_health
