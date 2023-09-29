extends Node2D

var messages_battle_necromancer_001 = [
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "...",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Pierdes tu tiempo intentando derrotarme",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Los Espiritus Elementales ya estan bajo mi control",
			"event"   : false
		},
		{
			"issuing" : "necro",
			"title"   : "Nigromante",
			"message" : "Y no hay nada que puedas hacer",
			"event"   : false
		}	
	]

var dead_last_invoque = false

var number_message_first_msg  = 1
var number_message_second_msg = 1
var speed_text    = 0.08
var end_first_msg = false

var box_msg  

func _ready():
	$CanvasLayer.changeBackMusic2("res://sfx/background_wind_chimes_loop.wav", -10)
	$CanvasLayer.changeBackMusic("res://sfx/05 gaseous tethanus.ogg", 0)
	if Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y
	
	if Msgs.dlg_003.is_done:
		$Actions.queue_free()

func _process(_delta):
	if not Msgs.forgot and Msgs.in_dialog:		
		if Input.is_action_just_pressed("attack") and not Msgs.dlg_003.is_done:
			self.showMessages()
			Msgs.forgot = true

func _on_EnterBattle_body_entered(body):
	Msgs.forgot = false
	self.box_msg = null
	if body.get_name() == 'knight':		
		self.initDialog()
		$knight.idle()

func initDialog () :
	if not Msgs.dlg_003.is_done:
		$Actions/Dialog001Boss/BtnToPress.visible = true
		Msgs.in_dialog      = true
		Msgs.dlg_003.active = true

func showMessages () :
	if number_message_first_msg < messages_battle_necromancer_001.size():
		if self.box_msg:
			self.box_msg.queue_free()
		self.box_msg  = self.addChildBoxMsg()
		self.box_msg._set_message(messages_battle_necromancer_001[number_message_first_msg])
		
	else:
		self.box_msg.queue_free()
		Msgs.in_dialog       = false				
		Msgs.forgot          = false
		self.call_deferred("_cd_init_battle")

	number_message_first_msg += 1

func addChildBoxMsg():
	var box        = load("res://scenes/GUI/MsgBoxA.tscn")
	box            = box.instance()
	box.position.x = $knight.position.x +20
	box.position.y = $knight.position.y + 80	
	self.add_child(box)
	return box

func _cd_init_battle ():	
	$CanvasLayer.changeBackMusic("res://sfx/12 final battle.ogg", 0)
	$Actions/Dialog001Boss/BtnToPress.visible = false
	$Areas/EnterBattle.queue_free()
	$BossObelisk/CollisionShape2D.disabled = false
	$BossObelisk/AnimationPlayer.play("action")
	$BossObelisk2/CollisionShape2D.disabled = false
	$BossObelisk2/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	$CanvasLayer/BossBarControl.visible = true

func _finish_battle () :
	self.call_deferred("_cd_finish_battle")
		
func _cd_finish_battle () :
	$CanvasLayer.changeBackMusic2("res://sfx/background_wind_chimes_loop.wav", -10)
	$CanvasLayer.changeBackMusic("res://sfx/05 gaseous tethanus.ogg", 0)
	$BossObelisk/CollisionShape2D.disabled = true
	$BossObelisk/AnimationPlayer.play("off")
	$BossObelisk2/CollisionShape2D.disabled = true
	$BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false
