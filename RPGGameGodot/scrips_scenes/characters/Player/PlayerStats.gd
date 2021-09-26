extends "res://scrips_scenes/utils/stats/Stats.gd"

export var max_experience = 300            setget set_max_exp
var        experience     = max_experience setget set_exp

export var max_mana = 60        setget set_max_mana
var mana            = max_mana  setget set_mana

var attack  = 20
var speed   = 150

var magic_damage  = 5
var magic_defense = 5

var willpower = 20
var luck      = 30
var accuracy  = 15

signal mana_changed(value)
signal max_mana_changed(value)
signal no_mana()

signal exp_changed(value)
signal max_exp_changed(value)
signal max_exp_reached()

func _ready():
	self.mana       = max_mana
	self.experience = 0
	
func set_max_mana(value):
	max_mana = value
	self.mana = min(mana, max_mana)
	emit_signal("max_mana_changed",max_mana)

func set_mana(value):
	mana = value
	emit_signal("mana_changed", value)
	if mana <= 0:
		emit_signal("no_mana")
		
func reduce_mana(value):
	self.mana -= value
		
func set_max_exp(value):
	max_experience  = value
	self.experience = min(experience, max_experience)
	emit_signal("max_exp_changed",max_experience)

func set_exp(value):
	experience = value
	emit_signal("exp_changed", value)
	if experience == max_experience:
		emit_signal("max_exp_reached")


 

 
