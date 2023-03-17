extends Node2D

var messages_second_meeting = [
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : ""
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "gusto en verte nuevamente 'viejo' amigo..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "haz seguido mi consejo y te dirijes al pueblo... muy bien."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "Sí, espero entender que sucede. Esas cosas, mi tumba, mi muerte... y mi 'despertar'..."
	},

	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "tranquilo 'viejo' amigo, todo a su debido momento."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Ahora necesito que me hagas un favor... y es que yo ya estoy muy viejo para ciertas cosas..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "... sin ofender..."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... ... ..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "da la casualidad que estoy rumbo a la IGLESIA que esta de camino al pueblo..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "ahí yo tengo mis negocios con las cosas que aqui nadie ya usa... tú entiendes."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... ... ..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "No importa... el asunto es que, allá arriba, un tipo se ha tomado el paso a la IGLESIA."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Serías tan amable de ir a pedirle que se vaya... ?"
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "digamos que su presencia no favorece mi negocio."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Pero tranquilo. te ayudaré... ten esto. y nos vemos más tarde"
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "No mueras... (risas)"
	},
	{
		"issuing" : "player",
		"title"   : "Sistema",
		"message" : "Has recibido una Runa"
	},
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
	if Msgs.dlg_002.is_done :
		Msgs.forgot    = false
		Msgs.in_dialog = false
	else:		
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
		
func showMessages () :

	if number_message < messages_second_meeting.size():
		if self.player_msg_box:
			self.player_msg_box.queue_free()
		self.player_msg_box  = self.addChildPlayerMsgBox()
		self.player_msg_box._set_message(messages_second_meeting[number_message])
		
	else:
		self.player_msg_box.queue_free()
		Msgs.in_dialog       = false
		$OldMan.is_stop      = false
		Msgs.dlg_002.is_done = true		
		Msgs.forgot          = false
		var item           = ItemsGbl._get_item_by_code(1027)
		Players._add_item(item, 1)

	number_message += 1

func addChildPlayerMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $knight.position.x 
	box.position.y = $knight.position.y + 50
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
	$BossObelisk/CollisionShape2D.disabled = false
	$BossObelisk/AnimationPlayer.play("action")
	$BossObelisk2/CollisionShape2D.disabled = false
	$BossObelisk2/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	
func _finish_battle () :
	self.call_deferred("_cd_finish_battle")
		
func _cd_finish_battle () :
#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.winner_song)
#	$CanvasLayer/BackAudio.play()
	
	$BossObelisk/CollisionShape2D.disabled = true
	$BossObelisk/AnimationPlayer.play("off")
	$BossObelisk2/CollisionShape2D.disabled = true
	$BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false
