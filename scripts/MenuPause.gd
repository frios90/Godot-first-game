extends Control
signal e

const row_list_item = preload("res://scenes/Elements/RowListItems.tscn")
var info_item_selected

func _ready ():
	self.initOrUpdateDataPlayer()
	
func _load_accessories() :
	
	var wpn = ItemsGbl._get_item_by_code(Players.selected.weapon_selected) if Players.selected.weapon_selected else false 
	if wpn:
		$Accessories/Weapon/input.texture = load(wpn.icon) 
		
	var arm = ItemsGbl._get_item_by_code(Players.selected.armory_selected) if Players.selected.armory_selected else false 
	if arm :
		$Accessories/Armory/input.texture = load(arm.icon) 
		
	var runes_attack = Players.selected.action_attack_runes
	var rune_001     = ItemsGbl._get_item_by_code(runes_attack[0]) if runes_attack[0] else false
	var rune_002     = ItemsGbl._get_item_by_code(runes_attack[1]) if runes_attack[1] else false
	if rune_001:
		$Accessories/RuneWeapon001/input.texture = load(rune_001.icon) 
	if rune_002:
		$Accessories/RuneWeapon002/input.texture = load(rune_002.icon)
		
	var runes_defense = Players.selected.action_defense_runes
	var rune_003     =  ItemsGbl._get_item_by_code(runes_defense[0]) if runes_defense[0] else false
	var rune_004     =  ItemsGbl._get_item_by_code(runes_defense[1]) if runes_defense[1] else false
	if rune_003:
		$Accessories/RuneArmory001/input.texture = load(rune_003.icon) 
	if rune_004:
		$Accessories/RuneArmory002/input.texture = load(rune_004.icon)
	
func initOrUpdateDataPlayer ():
	var runes_attack  = Players._get_runes_attack()
	var runes_defense = Players._get_runes_defense()
	self._load_items()
	self._load_accessories()
	$Stats/Values/hp.text            = str(str(int(Players.selected.stats.current_hp)), " / ", str(Players.selected.stats.health_points))
	$Stats/Values/mp.text            = str(str(int(Players.selected.stats.current_mp)), " / ", str(Players.selected.stats.magic_points))
	$Stats/Values/stamine.text       = str(int(Players.selected.stats.stamine))
	$Stats/Values/strength.text      = str(int(Players.selected.stats.strength))
	$Stats/Values/intelligence.text  = str(int(Players.selected.stats.intelligence))
	$Stats/Values/speed.text         = str(int(Players.selected.stats.speed)) 
	$Stats/Values/luck.text          = str(int(Players.selected.stats.speed))
	$Stats/Values/totalattack.text   = str(int(Players._get_attack()))
	$Stats/Values/totaldefense.text   = str(int(Players._get_defense()))
	$Stats/Values/defensenatural.text = str(ItemsGbl._get_item_by_code(Players.selected.armory_selected).defense)
	$Stats/Values/attacknatural.text = str(ItemsGbl._get_item_by_code(Players.selected.weapon_selected).attack)
	$Stats/Values/attackflame.text   = str(runes_attack.flame)
	$Stats/Values/attacksand.text    = str(runes_attack.sand)
	$Stats/Values/attackwind.text    = str(runes_attack.wind)
	$Stats/Values/attackliquid.text  = str(runes_attack.liquid)
	$Stats/Values/defenseflame.text  = str(runes_defense.flame)
	$Stats/Values/defensesand.text   = str(runes_defense.sand)
	$Stats/Values/defensewind.text   = str(runes_defense.wind)
	$Stats/Values/defenseliquid.text = str(runes_defense.liquid)
	
func _process(delta):
	Env.non_use = delta
	self.setActionItems()
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false
		emit_signal("e")
		self.queue_free()	
		
	if self.info_item_selected and not self.info_item_selected.data.can_use:
		$InfoItem/BtnUse.visible = false 
	else:
		$InfoItem/BtnSelect.visible = true

	if self.info_item_selected and not self.info_item_selected.data.can_select:
		$InfoItem/BtnSelect.visible = false 
	else:
		$InfoItem/BtnSelect.visible = true
		
	if self.info_item_selected and not self.info_item_selected.data.is_rune:
		$InfoItem/BtnEquipAttack.visible = false 
		$InfoItem/BtnEquipDefense.visible = false 
	else:
		$InfoItem/BtnEquipAttack.visible = true 
		$InfoItem/BtnEquipDefense.visible = true 
		
	if self.info_item_selected and not (self.info_item_selected.data.is_weapon or self.info_item_selected.data.is_weapon):
		$InfoItem/Equipar.visible = false 
	else:
		$InfoItem/Equipar.visible = true
		
	
func setActionItems () :
	var empty_icon = "res://assets/Gui/TexturaBlue/Scroll Button.png"
	if Players.selected.action_items[0]:
		var item1 =  Players._get_player_item_by_code(Players.selected.action_items[0])
		$ItemsSelected/IconItem001.texture = load(item1.data.icon)
	else:
		$ItemsSelected/IconItem001.texture = null
	if Players.selected.action_items[1]:		
		var item2 = Players._get_player_item_by_code(Players.selected.action_items[1])
		$ItemsSelected/IconItem002.texture = load(item2.data.icon)
	else:
		$ItemsSelected/IconItem002.texture = null
	if Players.selected.action_items[2]:
		var item3 = Players._get_player_item_by_code(Players.selected.action_items[2])
		$ItemsSelected/IconItem003.texture = load(item3.data.icon)
	else:
		$ItemsSelected/IconItem003.texture = null


func _load_items () :
	var lenInIventory = len($Items/ScrollContainer/VBoxContainer.get_children())
	for e in range(lenInIventory):
		$Items/ScrollContainer/VBoxContainer.remove_child($Items/ScrollContainer/VBoxContainer.get_children()[0])
	var pre_y = false
	for i in range (len(Players.selected.items)):
		var row = row_list_item.instance()		
		var img = load(Players.selected.items[i].data.icon)
		row.get_node("Sprite").texture = img
		row.get_node("item").text      = Players.selected.items[i].data.name
		row.get_node("cantidad").text  = str(Players.selected.items[i].qty)
		row.rect_min_size = Vector2(350, 35)
		row.item          = Players.selected.items[i]
		
		$Items/ScrollContainer/VBoxContainer.add_child(row) 


func _on_ButtonQuit_pressed():
	Env.non_use = get_tree().change_scene("res://scenes/Menu.tscn")

func _on_ButtonContinue_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()


func _on_BtnSelect_pressed():
	Players._add_action_item(self.info_item_selected)

func _on_RemoveItem001_pressed():
	Players._remove_action_item(0)

func _on_RemoveItem002_pressed():
	Players._remove_action_item(1)

func _on_RemoveItem003_pressed():
	Players._remove_action_item(2)

func _on_BtnUse_pressed():
	Players._use_item_in_pause_menu(self.info_item_selected)


func _on_BtnEquipAttack_pressed():
	
	var runes_in_use = self._count_runes_in_use_by_code(self.info_item_selected.data.code)
	if runes_in_use == self.info_item_selected.qty:
		return
		
	if !Players.selected.action_attack_runes[0]:
		Players.selected.action_attack_runes[0] = self.info_item_selected.data.code
	elif !Players.selected.action_attack_runes[1]:
		Players.selected.action_attack_runes[1] = self.info_item_selected.data.code
	
	self.initOrUpdateDataPlayer()
	self._load_accessories()

func _on_BtnEquipDefense_pressed():	
	var runes_in_use = self._count_runes_in_use_by_code(self.info_item_selected.data.code)
	if runes_in_use == self.info_item_selected.qty:
		return	
	if !Players.selected.action_defense_runes[0]:
		Players.selected.action_defense_runes[0] = self.info_item_selected.data.code
	elif !Players.selected.action_defense_runes[1]:
		Players.selected.action_defense_runes[1] = self.info_item_selected.data.code
		
	self.initOrUpdateDataPlayer()
	self._load_accessories()


func _count_runes_in_use_by_code (code):
	var count = 0
	count += 1 if Players.selected.action_attack_runes[0] and Players.selected.action_attack_runes[0] == code else 0
	count += 1 if Players.selected.action_attack_runes[1] and Players.selected.action_attack_runes[1] == code else 0
	count += 1 if Players.selected.action_defense_runes[0] and Players.selected.action_defense_runes[0] == code else 0
	count += 1 if Players.selected.action_defense_runes[1] and Players.selected.action_defense_runes[1] == code else 0
	return count

func _on_removeRuneDefense002_pressed():
	Players.selected.action_defense_runes[0] = false
	$Accessories/RuneArmory002/input.texture = null

func _on_removeRuneDefense001_pressed():
	Players.selected.action_defense_runes[1] = false
	$Accessories/RuneArmory001/input.texture = null

func _on_removeRuneAttack002_pressed():
	Players.selected.action_attack_runes[1] = false
	$Accessories/RuneWeapon002/input.texture = null

func _on_removeRuneAttack001_pressed():
	Players.selected.action_attack_runes[0] = false
	$Accessories/RuneWeapon001/input.texture = null


func _on_Equipar_pressed():
	if self.info_item_selected.data.on == "weapon":
		Players.selected.weapon_selected = self.info_item_selected.data.code
	if self.info_item_selected.data.on == "armory":
		Players.selected.armory_selected = self.info_item_selected.data.code
	self.initOrUpdateDataPlayer()
	self._load_accessories()
