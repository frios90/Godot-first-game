extends Control


var messages = [
	{
		"issuing" : "???????",
		"message" : "Pero que sorpresa, otro renacido. Ten esto a ver si te sirve para hacer mas que los otros."
	},
	{
		"issuing" : "???????",
		"message" : "Nos vemos."
	},
	{
		"issuing" : "player",
		"message" : "... renacido ... otros..."
	}
]

var number_message = 0
var speed_text     = .09
var end            = false
var forgot         = false

func _ready():

	$TextureRect2.visible = false


func _process(delta):
	if not forgot and Msgs.dlg_001.active:
		$TextureRect2.visible = true
		if Input.is_action_just_pressed("attack"):
			self.showMessages()
			forgot = true

func showMessages () :
	if number_message < messages.size():
		end = false
		$TextureRect2/Message.bbcode_text     = messages[number_message].message
		$TextureRect2/Message.percent_visible = 0
		$TextureRect2/Issuing.bbcode_text     =  messages[number_message].issuing if messages[number_message].issuing != "player" else Players.selected.name

		var duration = speed_text * messages[number_message].message.length()
		$Tween.interpolate_property(
			$TextureRect2/Message,"percent_visible",0,1,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		Env.in_dialog = false
		self.queue_free()
	number_message += 1
		


func _on_Tween_tween_completed(object, key):
	end = true
	forgot = false
	
