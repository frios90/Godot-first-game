extends Control
signal e

const row_list_item = preload("res://scenes/Elements/RowListItems.tscn")
var info_item_selected

func _ready ():
	self.initOrUpdateDataPlayer()
	
	

func initOrUpdateDataPlayer ():
	self._load_items()
	$Stats/Values.get_node("hp").text           = str(String(int(Players.selected.stats.current_hp)), " / ", String(Players.selected.stats.health_points))
	$Stats/Values.get_node("mp").text           = str(String(int(Players.selected.stats.current_mp)), " / ", String(Players.selected.stats.magic_points))
	$Stats/Values.get_node("stamine").text      = String(int(Players.selected.stats.stamine))
	$Stats/Values.get_node("strength").text     = String(int(Players.selected.stats.strength))
	$Stats/Values.get_node("intelligence").text = String(int(Players.selected.stats.intelligence))
	$Stats/Values.get_node("speed").text        = String(int(Players.selected.stats.speed)) 
	$Stats/Values.get_node("luck").text         = String(int(Players.selected.stats.speed))
	
func _process(delta):
	Env.non_use = delta
	self.setActionItems()
	
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false
		emit_signal("e")
		self.queue_free()	

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
		
	
func setActionItems () :
	var empty_icon = "res://assets/Gui/TexturaBlue/Scroll Button.png"
	if Players.selected.action_items[0]:
		var item1 =  Players._get_player_item_by_code(Players.selected.action_items[0])
		$ItemsSelected/IconItem001.texture = load(item1.data.icon)
	else:
		$ItemsSelected/IconItem001.texture = load(empty_icon)
	if Players.selected.action_items[1]:		
		var item2 = Players._get_player_item_by_code(Players.selected.action_items[1])
		$ItemsSelected/IconItem002.texture = load(item2.data.icon)
	else:
		$ItemsSelected/IconItem002.texture = load(empty_icon)
	if Players.selected.action_items[2]:
		var item3 = Players._get_player_item_by_code(Players.selected.action_items[2])
		$ItemsSelected/IconItem003.texture = load(item3.data.icon)
	else:
		$ItemsSelected/IconItem003.texture = load(empty_icon)


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
	pass # Replace with function body.


func _on_BtnEquipDefense_pressed():
	pass # Replace with function body.
