extends KinematicBody2D

export (int) var maxSpeed        = 50
export (int) var scaleX          = -1
var motion                       = Vector2(0, 0)
const up                         = Vector2(0, -1)
var attack                       = 0

func _ready():	
	pass
	
func _process(_delta):	
	motion.x = maxSpeed	
	if $RayBoom.is_colliding():
		self.motion.x = 0		
		$AnimationPlayer.play("boom")
	Env.non_use = move_and_slide(motion, up)

func _call_boom ():	
	queue_free()
