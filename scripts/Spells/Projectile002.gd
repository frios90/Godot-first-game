extends KinematicBody2D

export (int) var maxSpeed  = 25
export (int) var scaleX    = -1
var motion                 = Vector2(0, 0)
const up                   = Vector2(0, -1)
var attack                 = 0
var timer_end = 0
var limit_end = 150
func _ready():	
	pass
	
func _process(delta):	
	motion.x = maxSpeed	
	move_and_slide(motion, up)
	timer_end +=1
	if timer_end == limit_end :
		queue_free()

func _on_AttackArea_body_entered(body):
	queue_free()
