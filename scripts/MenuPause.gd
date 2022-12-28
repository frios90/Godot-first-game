extends Control
signal e

func _ready ():
	$Statistics.get_node("00-lvl").text             = str("Lvl. ",String(Players.selected.stats.level))
	$Statistics.get_node("01-name").text            = String(Players.selected.name)
	$Statistics.get_node("Gui-max-hp").text         = str(String(Players.selected.stats.current_hp), " / ", String(Players.selected.stats.health_points))
	$Statistics.get_node("Gui-fuerza").text         = String(Players.selected.stats.strength)
	$Statistics.get_node("Gui-ataque").text         = String(Players._get_attack())
	$Statistics.get_node("Gui-velocidad").text      = String(Players.selected.stats.speed)
	$Statistics.get_node("Gui-experiencia").text    = String(Players.selected.stats.experience)
	$Statistics.get_node("Gui-next-lvl").text       = String(Util.round_dicimal((Players.selected.stats.next_level - Players.selected.stats.experience), 0))
	$Statistics.get_node("Gui-defensa").text        = String(Players._get_defense())
	$Statistics.get_node("Gui-inteligencia").text   = String(Players.selected.stats.intelligence)
	$Statistics.get_node("Gui-ataque-magico").text  = String(Players._get_attack_magic())
	$Statistics.get_node("Gui-defensa-magica").text = String(Players._get_defense_magic())
	$Statistics.get_node("Gui-suerte").text         = String(Players.selected.stats.luck)
	
func _process(delta):
	Env.non_use = delta
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false
		emit_signal("e")
		self.queue_free()

func _on_ButtonQuit_pressed():
	Env.non_use = get_tree().change_scene("res://scenes/Menu.tscn")

func _on_ButtonContinue_pressed():
	get_tree().paused = false
	emit_signal("e")
	self.queue_free()
