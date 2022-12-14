extends Node

onready var selected = gustaph

var gustaph = {
	"name" : "Gustaph",
	"gems" : 0,
	"increase_stats" : 0.2, 
	"increase_level" : 0.7,
	"dead": false,
	"init_position_stage" : {
		"x" : -1512,
		"y" : -80
	},
	"stats" : {
		"level"           : 1,
		"experience"      : 0,
		"health_points"   : 130,
		"magic_points"    : 90,
		"stamine"         : 100,
		"strength"        : 45,
		"intelligence"    : 12,
		"speed"           : 22.3,
		"luck"            : 1,
		"next_level"      : 900,
		"current_hp"      : 130,
		"current_mp"      : 90,
		"current_stamine" : 100,
		"dash_speed"      : 600,
		"move_speed"      : 22.3 * 10,
		"jump_height"     : -620,
		"gravity"         : 750,
		"mase"            : 1.9,
		"stamine_cost"    : 15,
		"stamine_recovery": 0.4
	},
	"weapon_selected" : {
		"name"         : "INIT_SWORD",
		"attack"       : 5,
		"attack_magic" : 0
	},
	"armory_selected" : {
		"name"          : "INIT_ARMORY",
		"defense"       : 1,
		"defense_magic" : 0
	},
	"selected_item" : {		
		"name"     : "potion",	
		"max"      : 3,
		"current"  : 3,
		"recovery" : 0.8	
	},
	"last_save_point": ""
}

func _ready ():
	selected = gustaph

var coins       = 0
var points      = 0



func _get_attack (enemy_defense = false):
	if not enemy_defense:
		return self.selected.stats.strength + self.selected.weapon_selected.attack
	else :
		return (self.selected.stats.strength + self.selected.weapon_selected.attack) - enemy_defense

func _get_defense ():
	return self.selected.stats.strength + self.selected.armory_selected.defense

func _get_attack_magic ():
	return self.selected.stats.intelligence + self.selected.weapon_selected.attack_magic

func _get_defense_magic ():
	return self.selected.stats.intelligence + self.selected.armory_selected.defense_magic

func _get_potion_recovery ():
	return  self.selected.stats.health_points * self.selected.selected_item.recovery


	

