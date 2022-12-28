extends CanvasLayer

var screenPause : String = "res://scenes/MenuPause.tscn" 
var paused     : Object = null

func _ready () :		
	$LabelTotalGems.text  = String(Players.selected.gems)
	$LabelPotas.text      = String(Players.selected.selected_item.current)
	$HPbar.value          = (float(100) / float(Players.selected.stats.health_points)) * float(Players.selected.stats.current_hp)
	$MPbar.value          = (float(100) / float(Players.selected.stats.magic_points)) * float(Players.selected.stats.current_mp)
	$StamineBar.value     = (float(100) / float(Players.selected.stats.stamine)) * float(Players.selected.stats.current_stamine)	
	$GuiLvlLabel.text     = String(Players.selected.stats.level)
	$HPBarBoss.visible    = false
	$BackAudio.playing    = true
	
func _process(delta):
	Env.non_use = delta
	if Input.is_action_just_pressed("pause"):
		paused = load(screenPause).instance()
		add_child(paused)
#		paused.connect("e", self, "on_paused_quit")
		Env.non_use = paused		
		get_tree().paused = true
		
func on_paused_quit() -> void:
	paused = null

	
func handleUpdateHpBarBoss (max_life, current_life):
	$HPBarBoss.value = (float(100) / float(max_life)) * float(current_life)

func handleGemCollected(qty):
	Players.selected.gems += qty
	$LabelTotalGems.text = String(Players.selected.gems)

func handleSetHpBar ():
	$LabelLife.text = String(Players.selected.stats.current_hp)		
	$HPbar.value    = (float(100) / float(Players.selected.stats.health_points)) * float(Players.selected.stats.current_hp)	
		
func handleUploadPotas ():
	$LabelPotas.text = String(Players.selected.selected_item.current)
	
func handleSetLevelInUiPlayer () :
	$GuiLvlLabel.text = String(Players.selected.stats.level)
	
func handleSetStamineBar ():
	$StamineBar.value  = (float(100) / float(Players.selected.stats.stamine)) * float(Players.selected.stats.current_stamine)	

