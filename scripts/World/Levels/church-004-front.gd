extends Node2D

var messages = [
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Pero que sorpresa, otro renacido. Ten esto... a ver si te sirve para hacer más que los otros.."
	},
	{
		"issuing" : "player",
		"title"   : "Sistema",
		"message" : "Haz recibido una poción"
	},
	{
		"issuing" : "old-man",
		"title"   : "Viejo",
		"message" : "Nos vemos."
	},
	{
		"issuing" : "player",
		"title"   : "Gustaph",
		"message" : "... renacido ... otros..."
	}
]

var number_message = 0
var speed_text     = 0.05
var end            = false

var old_man_msg_box 
var player_msg_box  

func _ready():
	pass # Replace with function body.

func _process(delta):
	self.initDialog()
	if not Msgs.forgot:
		if Input.is_action_just_pressed("attack"):
			self.showMessages()
			Msgs.forgot = true


func initDialog () :
	if $OldMan/RayInitDialog.is_colliding() and $OldMan.is_stop ==  false:
		$OldMan.is_stop = true
		$OldMan/AnimationPlayer.play("stop")
		$OldMan.motion.x = 0
		Msgs.in_dialog      = true
		Msgs.dlg_001.active = true
		$OldMan/RayInitDialog.enabled = false
		
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
		Msgs.in_dialog = false
		$OldMan/AnimationPlayer.play("walk")
		$OldMan.motion.x = $OldMan.maxSpeed * -1
		$OldMan.is_stop = false
	number_message += 1
	
func addChildOldManMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $OldMan.position.x + 100
	box.position.y = $OldMan.position.y - 100
	self.add_child(box)
	return box
	
func addChildPlayerMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $knight.position.x -100
	box.position.y = $knight.position.y - 100
	self.add_child(box)
	return box
