extends CanvasLayer

func _ready () :
	
	$LabelTotalCoins.text = String(Env.coins)
	$LabelExp.text        = String(Env.experience)
	$LabelLevel.text      = String(Env.level)
	$LabelNextLevel.text  = String(Env.next_level)
	$LabelLife.text       = String(Env.current_life)
	$LabelPotas.text      = String(Env.current_potions)
	$HPbar.value          = (float(100) / float(Env.life)) * float(Env.current_life)
	
	$HPBarBoss.visible = false


func handleStartFigthingBoss ():	
	get_parent().get_node("BossTheme").playing = true
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
	Env.experience +=  points
	$LabelExp.text = String(Env.experience)
	calculateLevel()

func calculateLevel ():
	if Env.experience >= Env.next_level:
		Env.level += 1
		Env.next_level = Env.next_level * Env.level * Env.increase_level
		$LabelNextLevel.text = String(Env.next_level)
		$LabelLevel.text = String(Env.level)
		Env.strength = Env.strength + (Env.level * Env.increase_stats)		
		#aqui esto deberia variar en caso de alguna variable como un arma
		Env.attack = Env.strength
		
func handleSetHpBar ():
	$LabelLife.text = String(Env.current_life)		
	$HPbar.value = (float(100) / float(Env.life)) * float(Env.current_life)	
		
func handleUploadPotas ():
	$LabelPotas.text = String(Env.current_potions)



