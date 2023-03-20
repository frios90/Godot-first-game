extends KinematicBody2D
const gravity                    = 250
var speed = 300
var motion                       = Vector2(0, 0)
const up                         = Vector2(0, -1)
var attack = 30

func _process(delta):	
	self.motion.x = self.speed
	Env.non_use = move_and_slide(motion, up)
	if $RayCast2D.is_colliding() :
		self.queue_free()
