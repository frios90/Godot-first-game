extends KinematicBody2D
const up                 = Vector2(0, -1)
var attack       = 45

var is_attacking = false
var parent_position

var limitTimerLap = 25
var timerLap      = 24
var useTween      = 1
var current_life          = 1
var speed = 100
var start = false
var motion = Vector2(0,0)

func _ready():
	pass
#	$AnimationPlayer.play("action")

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword") and self.start:		
		Util.get_an_script("Camera2D").trauma = true
		get_parent().skulls -= 1
		self.queue_free()
