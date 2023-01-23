extends Node2D

var messages = [
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : ""
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Vaya... tanto alboroto para esto?, sabía que algo extraño ocurría pero ..."
	},
	
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Este lugar un criadero de muertos vivientes... (escupe)"
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "veamos.. tú luces diferente... digo, no te pareces es estos pobres desgraciados sin descanso ..."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... ... ... ..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "cuentame ... ¿por que has 'vuelto'?"
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... ... ..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "no importa. Ve al pueblo. Allá encontraras respuestas..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "si, según relatos antiguos, antes ya vinieron otros como tú ... en intentos fellidos por arreglar las cosas ..."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... ¿como yo? ... "
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "... de ser así, espero no acabes como ellos..."
	},	
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "... nos vemos, aqui ya no hay nada de valor y tus 'amigos' no muy de fiar... tu entiendes. Ten esto... "
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... ¿amigos? ... "
	},
	{
		"issuing" : "player",
		"title"   : "Sistema",
		"message" : "Haz recibido una poción"
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "¿que quizo decir ese viejo?. Por ahora será mejor que salga de aquí..."
	}
]

var number_message = 1
var speed_text     = 0.08
var end            = false

var old_man_msg_box 
var player_msg_box  

func _ready():
	if Env.player_origin_position == "init":
		$knight.position.x = 128
		$knight.position.y = 912
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _process(delta):
	if Msgs.dlg_001.is_done :
		if self.has_node("OldMan"):
			$OldMan.queue_free()
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
		Msgs.dlg_001.active = true
		$OldMan/RayInitDialog.enabled = false
		self.old_man_msg_box = self.addChildOldManMsgBox()
		self.old_man_msg_box._set_message(messages[0])
		
func showMessages () :

	if number_message < messages.size():
		if messages[number_message].issuing == "player":
			if self.player_msg_box:
				self.player_msg_box.queue_free()
			self.player_msg_box  = self.addChildPlayerMsgBox()
			self.player_msg_box._set_message(messages[number_message])
		else:
			if self.old_man_msg_box:
				self.old_man_msg_box.queue_free()
			self.old_man_msg_box = self.addChildOldManMsgBox()
			self.old_man_msg_box._set_message(messages[number_message])
	else:
		self.old_man_msg_box.queue_free()
		self.player_msg_box.queue_free()
		Msgs.in_dialog       = false
		$OldMan.is_stop      = false
		Msgs.dlg_001.is_done = true
		var item = ItemsGbl._get_item_by_code(1001)
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
