extends Node

var init_position_stage = {
	"x" : -1512,
	"y" : -80,
	"flip" : 1
}


var coins       = 0
var points      = 0

const increase_stats = 0.2
const increase_level = 0.7

var player_name = "Gustaph"  

#stats

var level       = 1
var experience  = 0
var next_level  = 900

var plus_air_attack       = 1.6
var low_damage_air_attack = 0.7

var life         = 220
var strength     = 45
var intelligence = 12
var speed        = 22.3
var luck         = 1

var current_life = life *0.5

var weapon_selected = {
	"name" : "INIT_SWORD",
	"attack": 5,
	"attack_magic": 0
}

var armory_selected = {
	"name" : "INIT_ARMORY",
	"defense": 1,
	"defense_magic": 0
}

var memory_attack = strength + weapon_selected.attack
var attack        = strength + weapon_selected.attack
var defense       = strength + armory_selected.defense

var dead = false
var timer_loop_song = 0
var max_potions     = 3
var current_potions = 3

var recovery_potion = life * 0.8

func _get_attack ():
	return self.strength + self.weapon_selected.attack

func _get_defense ():
	return self.strength + self.armory_selected.defense
	
func _get_attack_magic ():
	return self.intelligence + self.weapon_selected.attack_magic

func _get_defense_magic ():
	return self.intelligence + self.armory_selected.defense_magic


func calculateLevel ():
	if Env.experience >= Env.next_level:
		Env.level     += 1
		Env.next_level = Env.next_level * Env.level * Env.increase_level
		Env.strength   = Env.strength + (Env.level * Env.increase_stats)
