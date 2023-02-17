extends Node2D

var messages_battle_necromancer_001 = [
	{
		"issuing" : "necro",
		"title"   : "Nigromante",
		"message" : "Vaya... conozco ese edor... pero no eres creación mía. Dime, quien te envía?"
	},
	{
		"issuing" : "player",
		"title"   : "Gustavo",
		"message" : "He recorrido un largo camino sin tener respuestas, no necesito mas preguntas!"
	},
	{
		"issuing" : "necro",
		"title"   : "Nigromante",
		"message" : "INSOLENTE... no te das cuenta a quien te diriges? ..."
	},
	{
		"issuing" : "player",
		"title"   : "Gustavo",
		"message" : "[escupe]"
	},
	{
		"issuing" : "player",
		"title"   : "Gustavo",
		"message" : "No eres mas que otro parasito, salido de su tumba..."
	},
	{
		"issuing" : "necro",
		"title"   : "Nigromante",
		"message" : "INSECTO... como te atreves? ..."
	},
	{
		"issuing" : "necro",
		"title"   : "Nigromante",
		"message" : "soy SOLOMON, rey de los muertos y claramente tú no eres creación mía y la verdad no importa de donde hayas salido ..."
	},
	{
		"issuing" : "necro",
		"title"   : "Nigromante",
		"message" : "formaras parte de mi ejercito de muertos, yo.. el Nigromante te sentencio a la agonia eterna..."
	},
]


var dead_last_invoque = false

var number_message_first_msg = 1
var speed_text    = 0.08
var end_first_msg = false

var box_msg  

func _ready():
	if Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _process(delta):
	if not Msgs.forgot and Msgs.in_dialog:		
		self.showMessages()
		Msgs.forgot = true


func _on_EnterBattle_body_entered(body):
	if body.get_name() == 'knight':
		if not DbBoss.necromancer_002.dead:
			self.initDialog()
			self.call_deferred("_cd_init_battle")


func initDialog () :
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
		Msgs.dlg_003.is_done = true
		var item             = ItemsGbl._get_item_by_code(1027)
		Players._add_item(item, 1)

	number_message_first_msg += 1

func addChildBoxMsg():
	var box        = load("res://scenes/GUI/MsgBoxA.tscn")
	box            = box.instance()
	box.position.x = $knight.position.x 
	box.position.y = $knight.position.y + 50
	self.add_child(box)
	return box

func _cd_init_battle ():

#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.bringer_of_deadth_001._battleAudio)
#	$CanvasLayer/BackAudio.play()
#	$Necromancer.motion.x = $Necromancer.maxSpeed
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
#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.winner_song)
#	$CanvasLayer/BackAudio.play()	
	
	$BossObelisk/CollisionShape2D.disabled = true
	$BossObelisk/AnimationPlayer.play("off")
	$BossObelisk2/CollisionShape2D.disabled = true
	$BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false
