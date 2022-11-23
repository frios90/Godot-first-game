extends CanvasLayer

func _ready () :
	get_parent().get_node("SfxBg").playing = true
	get_parent().get_node("SfxBg02").playing = true
	$LabelTotalCoins.text = String(Env.coins)
	$LabelExp.text        = String(Env.experience)
	$LabelLevel.text      = String(Env.level)
	$LabelNextLevel.text  = String(Env.next_level)
	$LabelLife.text       = String(Env.current_life)
	$HPbar.value          = (float(100) / float(Env.life)) * float(Env.current_life)
	

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
		



