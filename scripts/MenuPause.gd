extends Control
signal e

func _ready ():
	$Statistics.get_node("00-lvl").text          = str("Lvl. ",String(Env.level))
	$Statistics.get_node("01-name").text         = String(Env.player_name)
	$Statistics.get_node("Gui-max-hp").text      = str(String(Env.current_life), " / ", String(Env.life))
	$Statistics.get_node("Gui-fuerza").text      = String(Env.strength)
	$Statistics.get_node("Gui-ataque").text      = String(Env._get_attack())
	$Statistics.get_node("Gui-velocidad").text   = String(Env.speed)
	$Statistics.get_node("Gui-experiencia").text = String(Env.experience)
	$Statistics.get_node("Gui-next-lvl").text    = String(Util.round_dicimal((Env.next_level - Env.experience), 0))
	$Statistics.get_node("Gui-defensa").text       = String(Env._get_defense())
	$Statistics.get_node("Gui-inteligencia").text  = String(Env.intelligence)
	$Statistics.get_node("Gui-ataque-magico").text = String(Env._get_attack_magic())
	$Statistics.get_node("Gui-defensa-magica").text = String(Env._get_defense_magic())
	$Statistics.get_node("Gui-suerte").text         = String(Env.luck)
func _on_ButtonQuit_pressed():
	get_tree().quit()

func _on_ButtonContinue_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
