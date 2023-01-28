extends CanvasLayer

var screenPause : String = "res://scenes/MenuPause.tscn" 
var paused      : Object = null

func _ready () :		
	$PopUpItem.visible    = false
	$PlayerBarControl/LabelTotalGems.text  = String(Players.selected.gems)
	$PlayerBarControl/HPbar.value          = (float(100) / float(Players.selected.stats.health_points)) * float(Players.selected.stats.current_hp)
	$PlayerBarControl/MPbar.value          = (float(100) / float(Players.selected.stats.magic_points)) * float(Players.selected.stats.current_mp)
	$PlayerBarControl/StamineBar.value     = (float(100) / float(Players.selected.stats.stamine)) * float(Players.selected.stats.current_stamine)	
	$PlayerBarControl/GuiLvlLabel.text     = String(Players.selected.stats.level)
	$BossBarControl.visible                = false
	
func _process(delta):
	Env.non_use = delta
	self.paused()		
	self.setCurrentSelectedItem()
	$PlayerBarControl/StrengthUp.visible = true if Players.selected.statuses_stack.strength.up > 0 else false
	$PlayerBarControl/SpeedUp.visible    = true if Players.selected.statuses_stack.speed.up > 0 else false
	$PlayerBarControl/StamineUp.visible  = true if Players.selected.statuses_stack.stamine.up > 0 else false
	
func paused ():
	if Input.is_action_just_pressed("pause"):
		paused = load(screenPause).instance()
		add_child(paused)
		Env.non_use = paused		
		get_tree().paused = true

func on_paused_quit() -> void:
	paused = null
	
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
