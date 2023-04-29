extends Node
var floating_text = preload("res://scenes/FloatingText.tscn")
var ftd           = 0
onready var selected = gustaph
var sound
	
var gustaph = {
	"change_scene_from_dead" : false,
	"last_save_point": "",
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
		"health_points"   : 200,
		"magic_points"    : 90,
		"stamine"         : 100,
		"strength"        : 70,
		"intelligence"    : 12,
		"speed"           : 17,
		"luck"            : 1,
		"next_level"      : 900,
		"current_hp"      : 200,
		"current_mp"      : 0,
		"current_stamine" : 100,
		"dash_speed"      : 600,
		"move_speed"      : 170,
		"jump_height"     : -450,
		"gravity"         : 600,
		"mase"            : 1.9,
		"stamine_cost"    : 14,
		"stamine_recovery": 0.4,
	},	
	"weapon_selected" : 1031, #por defecto
	"armory_selected" : 1038, #por defecto
	"selected_item"   : 0,
	"items"           : [],
	"action_items" : [false, false, false],
	"action_attack_runes"  : [false, false],
	"action_defense_runes" : [false, false],	
	"statuses_stack" : {
		"stamine"  : {
			"time" : 0,
			"up"   : 0
		},
		"strength" :{
			"time" : 0,
			"up"   : 0
		},
		"speed"    : {
			"time" : 0,
			"up"   : 0
		}
	}
}
var coins       = 0
var points      = 0

func _ready ():
	selected = gustaph	
	
func _process (_delta) :	
	if self.selected.statuses_stack.speed.up > 0:
		self.selected.stats.move_speed = 220
		
	if not Env.end_game:
		var has_item_1 = self._get_player_item_by_code(1023)
		var has_item_2 = self._get_player_item_by_code(1024)
		var has_item_3 = self._get_player_item_by_code(1025)
		var has_item_4 = self._get_player_item_by_code(1026)

		if has_item_1 and has_item_2 and has_item_3 and has_item_4:
			Env.end_game = true
			call_deferred("_call_def_end_game_animation")
	
func _call_def_end_game_animation ():
	yield(get_tree().create_timer(2), "timeout")	

	Env.non_use =  get_tree().change_scene("res://scenes/World/PassTown/Last.tscn")
	
func _get_attack (enemy_defense = false, resistance = false):
	var weapon_attack    = ItemsGbl._get_item_by_code(self.selected.weapon_selected).attack if self.selected.weapon_selected else 0	
	var effective_attack = self.selected.stats.strength	
	var runes_attack     = self._get_runes_attack()		
	effective_attack    += weapon_attack	
	
	if self.selected.statuses_stack.strength.up > 0:
		var attack_tonic_effect = int((float(self.selected.stats.strength) / 100) * selected.statuses_stack.strength.up)
		effective_attack += attack_tonic_effect

	if resistance and resistance.flame > 0:
		runes_attack.flame = runes_attack.flame - int((float(runes_attack.flame) / 100)* resistance.flame)
		runes_attack.flame = runes_attack.flame if runes_attack.flame >= 0 else 0
	if resistance and resistance.sand  > 0:
		runes_attack.sand = runes_attack.sand - int((float(runes_attack.sand) / 100)* 30)
		runes_attack.sand = runes_attack.sand if runes_attack.sand >= 0 else 0
	if resistance and resistance.wind > 0:			
		runes_attack.wind = runes_attack.wind - int((float(runes_attack.wind) / 100)* 30)
		runes_attack.wind = runes_attack.wind if runes_attack.wind >= 0 else 0
	if resistance and resistance.liquid > 0:		
		runes_attack.liquid = runes_attack.liquid - int((float(runes_attack.liquid) / 100)* 30)
		runes_attack.liquid = runes_attack.liquid if runes_attack.liquid >= 0 else 0
	
	effective_attack += runes_attack.flame
	effective_attack += runes_attack.sand
	effective_attack += runes_attack.wind
	effective_attack += runes_attack.liquid
	
	if not enemy_defense:
		return effective_attack
	else :
		return effective_attack - enemy_defense

func _get_runes_attack():
	var detail = {
		"flame"            : 0,
		"sand"             : 0,
		"wind"             : 0,
		"liquid"           : 0 
	}
	
	var base_calculate_attack = self.selected.stats.strength

	for i in range(len(self.selected.action_attack_runes)):
		if self.selected.action_attack_runes[i]:
			var rune = ItemsGbl._get_item_by_code(self.selected.action_attack_runes[i])			
			match rune.on:
				"flame": 
					detail.flame += int((float(base_calculate_attack) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
				"sand":
					detail.sand += int((float(base_calculate_attack) / 100) * rune.percentage)+ int(self.selected.stats.intelligence)
				"wind":
					detail.wind += int((float(base_calculate_attack) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
				"liquid": 
					detail.liquid += int((float(base_calculate_attack) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
	return detail

func _get_defense ():	
	var armor_defense   = ItemsGbl._get_item_by_code(self.selected.armory_selected).defense if self.selected.armory_selected else 0	
	var effective_defense = self.selected.stats.strength
	var runes_defense = self._get_runes_defense()
	effective_defense += runes_defense.flame
	effective_defense += runes_defense.sand
	effective_defense += runes_defense.wind
	effective_defense += runes_defense.liquid
	
	effective_defense += armor_defense
	
	return effective_defense

func _get_runes_defense():
	var detail = {
		"flame"            : 0,
		"sand"             : 0,
		"wind"             : 0,
		"liquid"           : 0 
	}
		
	var base_calculate_defense = self.selected.stats.strength

	for i in range(len(self.selected.action_defense_runes)):
		if self.selected.action_defense_runes[i]:
			var rune = ItemsGbl._get_item_by_code(self.selected.action_defense_runes[i])			
			match rune.on:
				"flame": 
					detail.flame  += int((float(base_calculate_defense) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
				"sand":
					detail.sand   += int((float(base_calculate_defense) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
				"wind":
					detail.wind   += int((float(base_calculate_defense) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
				"liquid": 
					detail.liquid += int((float(base_calculate_defense) / 100) * rune.percentage) + int(self.selected.stats.intelligence)
	return detail

func _add_item (item, qty):
	var new_item_to_add = {
		"data" : item,
		"qty"  : qty
	}		
	var validate_item_in_inventory_player = self._validate_exist_item_in_inventory(item)
	if validate_item_in_inventory_player:
		self._add_item_qty(new_item_to_add)		
	else:
		self._create_item_in_inventory(new_item_to_add)
	

func _validate_exist_item_in_inventory (item):
	for i in range(len(self.selected.items)):
		if self.selected.items[i].data.code == item.code:
			return true	
	return false
	
func _add_item_qty (item) -> void:
	for i in range(len(self.selected.items)):
		if self.selected.items[i].data.code == item.data.code:
			self.selected.items[i].qty += item.qty
			self._add_action_item(item)

func _create_item_in_inventory (item) -> void:	
	self.selected.items.append(item)
	self._add_action_item(item)

func _get_player_item_by_code (code):
	for i in range(len(self.selected.items)):
		if code and self.selected.items[i].data.code == code :
			return  self.selected.items[i]

func _add_action_item (item) :	
	if  self.selected.action_items[0] and self.selected.action_items[0] == item.data.code:
		return false
	if  self.selected.action_items[1] and self.selected.action_items[1] == item.data.code:
		return false
	if  self.selected.action_items[2]  and self.selected.action_items[2] == item.data.code:
		return false	
	
	if not self.selected.action_items[0]:
		self.selected.action_items[0] = item.data.code
	elif not self.selected.action_items[1]:
		self.selected.action_items[1] = item.data.code
	elif not self.selected.action_items[2]:
		self.selected.action_items[2] = item.data.code
	
func _remove_action_item (position) :
	self.selected.action_items[position] = false
	
func _erase_item (item):
	for i in range(len(self.selected.items)):	
		if self.selected.items[i].data.code == item.data.code:
			self.selected.items[i].qty -= 1
			if self.selected.items[i].qty == 0:
				self.selected.items.remove(i)
				if Util.get_an_script("MenuPause"):					
					Util.get_an_script("MenuPause").get_node("InfoItem").visible = false
				for j in range(len(self.selected.action_items)):
					if self.selected.action_items[j]:
						if self.selected.action_items[j] == item.data.code:
							self.selected.action_items[j] = false
							return
				return

func _set_aura_use_item (position):
	var aura        = load("res://scenes/Players/AuraHeal.tscn")
	aura            = aura.instance()
	aura.position.x = position.x
	aura.position.y = position.y	
	get_parent().add_child(aura)
	
func _use_item_in_pause_menu (item):	
	if item and item.data and item.qty > 0:
		self._use_hp_item(item)
		self._use_mp_item(item)
		self._use_cristal(item)
		self._use_tonic(item)	
		Util.get_an_script("MenuPause").initOrUpdateDataPlayer()

func _use_hp_item (item) :
	if item.data.on == "hp":		
		var recovery = float(float(self.selected.stats.health_points) / 100) * item.data.percentage
		ftd          = floating_text.instance()
		ftd.type     = "heal"
		ftd.amount   = recovery
		add_child(ftd)
		var hp_after_recovery          = self.selected.stats.current_hp + recovery
		self.selected.stats.current_hp = hp_after_recovery if hp_after_recovery < self.selected.stats.health_points else self.selected.stats.health_points
		Util.get_an_script("CanvasLayer").handleSetHpBar()
		self._erase_item(item)

func _use_mp_item (item) :
	if item.data.on == "mp":
		var recovery = float(float(self.selected.stats.magic_points) / 100) * item.data.percentage			
		ftd          = floating_text.instance()
		ftd.type     = "heal"
		ftd.amount   = recovery
		add_child(ftd)
		var mp_after_recovery             = self.selected.stats.current_mp + recovery
		self.selected.stats.current_mp = mp_after_recovery if mp_after_recovery < self.selected.stats.magic_points else self.selected.stats.magic_points
		Util.get_an_script("CanvasLayer").handleSetMpBar()
		self._erase_item(item)

func _use_cristal (item):
	match item.data.code:
		1016: #Cristal de hp
			self.selected.stats.health_points = int(self.selected.stats.health_points * float(item.data.percentage))
			self.selected.stats.current_hp = self.selected.stats.health_points 
			self._erase_item(item)
		1017: #Cristal de mp
			self.selected.stats.magic_points = int(self.selected.stats.magic_points * float(item.data.percentage))
			self.selected.stats.current_hp = self.selected.stats.health_points 
			self._erase_item(item)
		1018: #Cristal de stamina
			self.selected.stats.stamine = int(self.selected.stats.stamine * float(item.data.percentage))
			self._erase_item(item)
		1019: #Cristal de fuerza
			self.selected.stats.strength = self.selected.stats.strength * item.data.percentage
			self._erase_item(item)
		1020:
			self.selected.stats.intelligence = self.selected.stats.intelligence * item.data.percentage
			self._erase_item(item)
		1021:#Cristal de agilidad
			self.selected.stats.speed = self.selected.stats.speed * item.data.percentage
			self._erase_item(item)
		1022:#Cristal de  suerte
			self.selected.stats.luck = self.selected.stats.luck * item.data.percentage
			self._erase_item(item)

func _use_tonic (item):
	
	if (item.data.code == 1007 or item.data.code == 1008 or item.data.code == 1009) and self.selected.statuses_stack.stamine.up == 0:
		self.selected.statuses_stack.stamine.time = item.data.duration
		self.selected.statuses_stack.stamine.up   = item.data.percentage		
		self._erase_item(item)
		Env.non_use = get_tree().create_timer(item.data.duration).connect("timeout", self, "__finish_effect_tonic_stamine")	

		
	if (item.data.code == 1010 or item.data.code == 1011 or item.data.code == 1012) and self.selected.statuses_stack.strength.up == 0:
		self.selected.statuses_stack.strength.time = item.data.duration
		self.selected.statuses_stack.strength.up   = item.data.percentage
		self._erase_item(item)
		Env.non_use = get_tree().create_timer(item.data.duration).connect("timeout", self, "__finish_effect_tonic_strength")	

		
	if item.data.code == 1013 and self.selected.statuses_stack.speed.up == 0:
		self.selected.statuses_stack.speed.time = item.data.duration
		self.selected.statuses_stack.speed.up   = 1
		self._erase_item(item)
		Env.non_use = get_tree().create_timer(item.data.duration).connect("timeout", self, "__finish_effect_tonic_speed")	


func __finish_effect_tonic_stamine ():
	self.selected.statuses_stack.stamine.time = 0
	self.selected.statuses_stack.stamine.up   = 0
	
func __finish_effect_tonic_strength ():
	self.selected.statuses_stack.strength.time = 0
	self.selected.statuses_stack.strength.up   = 0
	
func __finish_effect_tonic_speed ():
	self.selected.statuses_stack.speed.time = 0
	self.selected.statuses_stack.speed.up   = 0
	self.selected.stats.move_speed = 170
