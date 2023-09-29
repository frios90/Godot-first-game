extends CanvasLayer

var screenPause : String = "res://scenes/MenuPause.tscn" 
var in_paused   : Object = null

var pressed_x = false
var use_joystick = false

func _ready () :	
	$PopUpItem.visible    = false
	$PlayerBarControl/LabelTotalGems.text  = String(Players.selected.gems)
	$PlayerBarControl/HPbar.value          = (float(100) / float(Players.selected.stats.health_points)) * float(Players.selected.stats.current_hp)
	$PlayerBarControl/MPbar.value          = (float(100) / float(Players.selected.stats.magic_points)) * float(Players.selected.stats.current_mp)
	$PlayerBarControl/StamineBar.value     = (float(100) / float(Players.selected.stats.stamine)) * float(Players.selected.stats.current_stamine)	
	$PlayerBarControl/GuiLvlLabel.text     = String(Players.selected.stats.level)
	$BossBarControl.visible                = false
	$Pad.visible                           = use_joystick
	
func _process(delta):
	$Pad.visible                           = use_joystick
	Env.non_use = delta
	self.paused()		
	self.setCurrentSelectedItem()
	$PlayerBarControl/StrengthUp.visible = true if Players.selected.statuses_stack.strength.up > 0 else false
	$PlayerBarControl/SpeedUp.visible    = true if Players.selected.statuses_stack.speed.up > 0 else false
	$PlayerBarControl/StamineUp.visible  = true if Players.selected.statuses_stack.stamine.up > 0 else false
	$PlayerBarControl/nextexp.text       = str(int(Players.selected.stats.next_level)) 
	$PlayerBarControl/exp.text           = str(int(Players.selected.stats.experience))
	self.loadSpeedSelectorItem()
	
func loadSpeedSelectorItem ():
		
	if Players.selected.action_items[0] :
		var slot_1 = Players._get_player_item_by_code(Players.selected.action_items[0])
		$ItemsSelector/slot_1/item.texture = load(slot_1.data.icon)
		$ItemsSelector/slot_1/item.visible = true
		$ItemsSelector/slot_1/item/qty.text = str(slot_1.qty)

		if Players.selected.selected_item == 0:
			$ItemsSelector/slot_1/item/frame.visible = true
		else:
			$ItemsSelector/slot_1/item/frame.visible = false
	else:
		$ItemsSelector/slot_1/item.texture = load("res://assets/Gui/Barras/circle-bar.png")
		$ItemsSelector/slot_1/item.visible = false

	if Players.selected.action_items[1] :
		var slot_2 = Players._get_player_item_by_code(Players.selected.action_items[1])
		$ItemsSelector/slot_2/item.texture = load(slot_2.data.icon)
		$ItemsSelector/slot_2/item.visible = true
		$ItemsSelector/slot_2/item/qty.text = str(slot_2.qty)
		if Players.selected.selected_item == 1:
			$ItemsSelector/slot_2/item/frame.visible = true
		else:
			$ItemsSelector/slot_2/item/frame.visible = false
	else:
		$ItemsSelector/slot_2/item.texture = load("res://assets/Gui/Barras/circle-bar.png")
		$ItemsSelector/slot_2/item.visible = false
	
	if Players.selected.action_items[2] :
		var slot_3 = Players._get_player_item_by_code(Players.selected.action_items[2])
		$ItemsSelector/slot_3/item.texture = load(slot_3.data.icon)
		$ItemsSelector/slot_3/item.visible = true
		$ItemsSelector/slot_3/item/qty.text = str(slot_3.qty)
		if Players.selected.selected_item == 2:
			$ItemsSelector/slot_3/item/frame.visible = true
		else:
			$ItemsSelector/slot_3/item/frame.visible = false
	else:
		$ItemsSelector/slot_3/item.texture = load("res://assets/Gui/Barras/circle-bar.png")
		$ItemsSelector/slot_3/item.visible = false
		
func paused ():
	if Input.is_action_just_pressed("pause"):
		in_paused = load(screenPause).instance()
		add_child(in_paused)
		Env.non_use = in_paused		
		get_tree().paused = true

func on_paused_quit() -> void:
	in_paused = null
	
func handleUpdateHpBarBoss (max_life, current_life):
	$BossBarControl/HPBarBoss.value = (float(100) / float(max_life)) * float(current_life)

func handleGemCollected(qty):
	Players.selected.gems += qty
	$PlayerBarControl/LabelTotalGems.text = String(Players.selected.gems)

func handleSetHpBar ():
	$PlayerBarControl/HPbar.value    = (float(100) / float(Players.selected.stats.health_points)) * float(Players.selected.stats.current_hp)	

func handleSetMpBar ():
	$PlayerBarControl/MPbar.value    = (float(100) / float(Players.selected.stats.magic_points)) * float(Players.selected.stats.current_mp)	
		
func handleUploadPotas ():
	$PlayerBarControl/LabelPotas.text = String(Players.selected.selected_item.current)
	
func handleSetLevelInUiPlayer () :
	$PlayerBarControl/GuiLvlLabel.text = String(Players.selected.stats.level)
	
func handleSetStamineBar ():
	$PlayerBarControl/StamineBar.value  = (float(100) / float(Players.selected.stats.stamine)) * float(Players.selected.stats.current_stamine)	

func setCurrentSelectedItem ():
	if Input.is_action_just_pressed("changeItem"):
		Players.selected.selected_item +=1
		if Players.selected.selected_item > 2:
			Players.selected.selected_item = 0
		
	var current_item = Players.selected.action_items[Players.selected.selected_item]
	current_item = Players._get_player_item_by_code(current_item) if current_item else false
	
	if current_item:
		$PlayerBarControl/ItemInCircleItems.visible = true
		$PlayerBarControl/ItemInCircleItems.texture = load(current_item.data.icon)
		$PlayerBarControl/LabelQtySelectedItem.text = str(current_item.qty)
	else:
		$PlayerBarControl/ItemInCircleItems.visible = false
		$PlayerBarControl/LabelQtySelectedItem.text = ""

func changeBackMusic (to_load, volume) :
	$BackAudio.stop()
	$BackAudio.stream = load(to_load)
	$BackAudio.volume_db = volume
	$BackAudio.play()

func changeBackMusic2 (to_load, volume) :
	$BackAudio2.stop()
	$BackAudio2.stream = load(to_load)
	$BackAudio2.volume_db = volume
	$BackAudio2.play()
	
func touchX () :
	print("tocando la x")

func _on_usejoystick_pressed():
	self.use_joystick = false if use_joystick else true
