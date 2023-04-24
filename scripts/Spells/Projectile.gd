extends KinematicBody2D

export (int) var maxSpeed        = 50
export (int) var scaleX          = -1
var motion                       = Vector2(0, 0)
const up                         = Vector2(0, -1)
var attack = 0

func _ready():	
	pass

	
func _process(delta):	
	motion.x = maxSpeed	
	Env.non_use = move_and_slide(motion, up)


func _on_AttackArea_body_entered(_body):
	queue_free()

