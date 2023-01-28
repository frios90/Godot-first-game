extends Node2D

var messages_second_meeting = [
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : ""
	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "Veo que has recobrado fuerzas, ver a los 'amigos' hace bien no? (risas)"
#	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "Tú otra vez viejo ...?"
	},
#
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "Viejo? los dice quien murio hace 500 años... (escupe)"
#	},
#	{
#		"issuing" : "player",
#		"title"   : "Gustaph",
#		"message" : "necesito que me cuentes que sucede ..."
#	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "te lo he dicho antes, estas 'cosas' despiertan y no hay quien las haga dormir nuevamente"
#	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "otros lo han intentado y al aprecer no le fue muy bien..."
#	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "pero deberas ir al pueblo... allá encontras más..."
#	},
#	{
#		"issuing" : "player",
#		"title"   : "Gustaph",
#		"message" : "que diablos pasa?! se suponia que el rito habia sido un exito... yo no debería estar aquí..."
#	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "(risas) pues alguien piensa lo contrario viejo amigo... anda sigue tu camino... ten esto"
#	},	
#	{
#		"issuing" : "player",
#		"title"   : "Sistema",
#		"message" : "Haz recibido Runa de la Flama"
#	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "Es algo que encontre en tu tumba cuando te fuiste... creo que a ti te servira más... ya tengo lo que buscaba"
#	},
#	{
#		"issuing" : "old-man",
#		"title"   : "Viejo",
#		"message" : "nos vemos! (risas) ... sí, este luce diferente"
#	},
#	{
#		"issuing" : "player",
#		"title"   : "Gustaph",
#		"message" : "de mi tumba? ese viejo ha estado saquendo tumbas?"
#	}
]




var number_message = 1
var speed_text     = 0.08
var end            = false

var old_man_msg_box 
var player_msg_box  
var bod_msg_box  

func _ready():
	if Players.selected.change_scene_from_dead :
		$knight.position.x = Players.selected.last_save_point.x
		$knight.position.y = Players.selected.last_save_point.y
		Players.selected.change_scene_from_dead = false
	elif Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	elif Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _process(delta):	
	self.initDialog()
	if not Msgs.forgot and Msgs.in_dialog:		
		if Input.is_action_just_pressed("attack"):
			self.showMessages()
			Msgs.forgot = true

func initDialog () :
	if $OldMan/RayInitDialog.is_colliding():
		$OldMan.motion.x = 0
		Msgs.in_dialog      = true
		Msgs.dlg_002.active = true
		$OldMan/RayInitDialog.enabled = false
		self.old_man_msg_box = self.addChildOldManMsgBox()
		self.old_man_msg_box._set_message(messages_second_meeting[0])
		
func showMessages () :

	if number_message < messages_second_meeting.size():
		if messages_second_meeting[number_message].issuing == "player":
			if self.player_msg_box:
				self.player_msg_box.queue_free()
			self.player_msg_box  = self.addChildPlayerMsgBox()
			self.player_msg_box._set_message(messages_second_meeting[number_message])
		else:
			if self.old_man_msg_box:
				self.old_man_msg_box.queue_free()
			self.old_man_msg_box = self.addChildOldManMsgBox()
			self.old_man_msg_box._set_message(messages_second_meeting[number_message])
	else:
		self.old_man_msg_box.queue_free()
		self.player_msg_box.queue_free()
		Msgs.in_dialog       = false
		$OldMan.is_stop      = false
		Msgs.dlg_002.is_done = true
		var item = ItemsGbl._get_item_by_code(1027)
		Players._add_item(item, 1)

	number_message += 1
	
func addChildOldManMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $OldMan.position.x 
	box.position.y = $OldMan.position.y - 100
	self.add_child(box)
	return box
	
func addChildPlayerMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $knight.position.x 
	box.position.y = $knight.position.y - 100
	self.add_child(box)
	return box
	
	
		
func _on_EnterBattle_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.bringer_of_deadth_001.dead:
			self.call_deferred("_cd_init_battle")
		
func _cd_init_battle ():
#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.bringer_of_deadth_001._battleAudio)
#	$CanvasLayer/BackAudio.play()
	$BringerOfDeath.withMoveAndFlip = 1
	$BringerOfDeath.motion.x = $BringerOfDeath.maxSpeed
	$Areas/EnterBattle.queue_free()
	$collision/BossObelisk/CollisionShape2D.disabled = false
	$collision/BossObelisk/AnimationPlayer.play("action")
	$collision/BossObelisk2/CollisionShape2D.disabled = false
	$collision/BossObelisk2/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	
func _finish_battle () :
	self.call_deferred("_cd_finish_battle")
		
func _cd_finish_battle () :
#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.winner_song)
#	$CanvasLayer/BackAudio.play()
	
	$collision/BossObelisk/CollisionShape2D.disabled = true
	$collision/BossObelisk/AnimationPlayer.play("off")
	$collision/BossObelisk2/CollisionShape2D.disabled = true
	$collision/BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false
