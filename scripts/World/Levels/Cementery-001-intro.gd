extends Node2D

var messages = [
	{
		"issuing" : "Sistema",
		"title"   : "Presiona 'C' para iniciar",
		"message" : ""
	},
	{
		"issuing" : "old-man",
		"title"   : "Gustavo",
		"message" : "espera !, necesito tu ayuda ..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Que diablos?... han pasado años y aún me sorprende verlos levantarse"
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Pero espera?... puedes hablar ?..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Gustavo",
		"message" : "Por favor, ayudame ... explicame que sucede. No recuerdo nada... he despertado en este sitio, esta tumba... "
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Este lugar un criadero de muertos vivientes... (escupe)"
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Espera... no te me acerques. Como es que puedes hablar?"
	},
	
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "... esto es extraño ... "
	},
	{
		"issuing" : "old-man",
		"title"   : "Gustavo",
		"message" : "Tranquilo no te haré daño, solo necesito saber donde estoy  y que esta pasando?"
	},
	{
		"issuing" : "player",
		"title"   : "Viejo",
		"message" : "mirate ... esto es increible ... año 846 ... chico, si esa es la fecha de tú muerte..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Gustavo",
		"message" : "Que año es este ?"
	},
	{
		"issuing" : "player",
		"title"   : "Viejo",
		"message" : "Viejo amigo... podrías ser ancestro de mis ancestro... 1476, te has perdido bastante"
	},
	{
		"issuing" : "old-man",
		"title"   : "Gustavo",
		"message" : "600 años... estoy muy confundido, recuerdo muy poco y no logro entender ..."
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "... Este no es un buen sitio para hablar... sal del cementerio y cuidate de tus 'amigos'..."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "'amigos' ? "
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Ve a PUBLOCCC. Ten esto y buena suerte. Quiza nos volvamos a encontrar"
	},	
	{
		"issuing" : "old-man",
		"title"   : "Gustavo",
		"message" : "al pueblo ?"
	},
	
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
		
		
func showMessages () :

	if number_message < messages.size():

		if self.player_msg_box:
			self.player_msg_box.queue_free()
		self.player_msg_box  = self.addChildPlayerMsgBox()
		self.player_msg_box._set_message(messages[number_message])
		
	else:
		self.player_msg_box.queue_free()
		Msgs.in_dialog       = false
		$OldMan.is_stop      = false
		Msgs.dlg_001.is_done = true
		var item = ItemsGbl._get_item_by_code(1001)
		Players._add_item(item, 1)

	number_message += 1
	

	
func addChildPlayerMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $knight.position.x 
	box.position.y = $knight.position.y + 50
	self.add_child(box)
	return box
