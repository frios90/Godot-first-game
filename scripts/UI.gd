extends CanvasLayer

var screenPause : String = "res://scenes/MenuPause.tscn" 
var paused     : Object = null

func _ready () :		
	$LabelTotalCoins.text = String(Env.coins)
	$LabelPotas.text      = String(Env.current_potions)
	$HPbar.value          = (float(100) / float(Env.life)) * float(Env.current_life)
	$HPBarBoss.visible    = false
	$BackAudio.playing    = true
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		paused = load(screenPause).instance()
		add_child(paused)
		paused.connect("e", self, "on_paused_quit")
		get_tree().paused = true
		
func on_paused_quit() -> void:
	paused = null

func handleStartFigthingBoss ():	
#	get_parent().get_node("BossTheme").playing = true
	$HPBarBoss.visible = true
	$HPBarBoss.value += 100	

func handleFinishFigthingBoss ():	
	get_parent().get_node("BossTheme").playing = false
	get_parent().get_node("VictorySound").playing = true
	get_parent().get_node("WaterBoss/CollisionShape2D").disabled = true
	$HPBarBoss.visible = false
	
func handleUpdateHpBarBoss ():
	var boss = get_parent().get_node("CocoDamon")
	$HPBarBoss.value = (float(100) / float(boss.life)) * float(boss.current_life)

func handleCoinCollected():
	Env.coins += 1
	$LabelTotalCoins.text = String(Env.coins)
	
func handleIncrementExp(points):
	Env.experience += points
	Env.calculateLevel()
		
func handleSetHpBar ():
	$LabelLife.text = String(Env.current_life)		
	$HPbar.value    = (float(100) / float(Env.life)) * float(Env.current_life)	
		
func handleUploadPotas ():
	$LabelPotas.text = String(Env.current_potions)

