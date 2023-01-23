extends Node
var floating_text = preload("res://scenes/FloatingText.tscn")
var ftd           = 0
onready var selected = gustaph

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
		"health_points"   : 130,
		"magic_points"    : 90,
		"stamine"         : 100,
		"strength"        : 45,
		"intelligence"    : 12,
		"speed"           : 22.3,
		"luck"            : 1,
		"next_level"      : 900,
		"current_hp"      : 130,
		"current_mp"      : 1,
		"current_stamine" : 100,
		"dash_speed"      : 600,
		"move_speed"      : 22.3 * 10,
		"jump_height"     : -420,
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
	"selected_item" : 0,
	"items"        : [],
	"action_items" : [false, false, false],
	"action_attack_rune"  : 0,
	"action_defense_rune" : 0,
	"action_accessory_01" : 0,
	"action_accessory_02" : 0,
	"action_accessory_03" : 0,
	"action_accessory_04" : 0,
	"statuses_stack" : {
		"stamine"  : 0,
		"strength" : 0,
		"speed"    : 0
	}
	
	
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

func _create_item_in_inventory (item) -> void:	
	self.selected.items.append(item)

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
	print("EN EL ERASE ITEMS")
	print(len(self.selected.items))
	for i in range(len(self.selected.items)):
		print("FLG001")
		print(i)
		print(self.selected.items[i])
		## MAS ERRORES AL QUERER USAR UN ITEM
		if self.selected.items[i].data.code == item.data.code:
			self.selected.items[i].qty -= 1
			if self.selected.items[i].qty == 0:
				self.selected.items.remove(i)
				#el problma esta aqui al querer eliminar el coso este
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
		#to-do el resto de la aplicacion de items (stamna, agilidad, fuerza, gemas... ...)
		self._erase_item(item)
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

func _use_cristal (item):
	match item.data.code:
		1016: #Cristal de hp
			self.selected.stats.health_points = int(self.selected.stats.health_points * float(item.data.percentage))
			self.selected.stats.current_hp = self.selected.stats.health_points 
		1017: #Cristal de mp
			self.selected.stats.magic_points = int(self.selected.stats.magic_points * float(item.data.percentage))
			self.selected.stats.current_hp = self.selected.stats.health_points 
		1018: #Cristal de stamina
			self.selected.stats.stamine = int(self.selected.stats.stamine * float(item.data.percentage))
		1019: #Cristal de fuerza
			self.selected.stats.strength = self.selected.stats.strength * item.data.percentage
		1020:
			self.selected.stats.intelligence = self.selected.stats.intelligence * item.data.percentage
		1021:#Cristal de agilidad
			self.selected.stats.speed = self.selected.stats.speed * item.data.percentage
		1022:#Cristal de  suerte
			self.selected.stats.luck = self.selected.stats.luck * item.data.percentage
		
	
