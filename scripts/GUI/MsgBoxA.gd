extends Node2D


var end            = false
var forgot         = false
var speed_text     = 0.02
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _process(delta):
#	if Input.is_action_pressed("attack") and not end :
#		self.speed_text = 0.02
#		print(self.speed_text)
#	else :
#		self.speed_text = 0.2
#

func _set_message (message):
	$Control/Message.bbcode_text     = message.message
	$Control/Message.percent_visible = 0
	$Control/Title.text              =  message.title
	var duration = speed_text * message.message.length()
	$Control/Tween.interpolate_property(
		$Control/Message,"percent_visible",0,1,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
	)
	$Control/Tween.start()

func _on_Tween_tween_completed(object, key):
	Msgs.forgot = false

