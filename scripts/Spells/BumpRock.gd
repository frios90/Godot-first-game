extends KinematicBody2D
const gravity                    = 250
var speed = 300
var motion                       = Vector2(0, 0)
const up                         = Vector2(0, -1)
var attack = 300

func _process(_delta):	
	self.motion.x = self.speed
	self.boom()
	Env.non_use = move_and_slide(motion, up)

func boom () :
	if $RayBoom.is_colliding():		
		self.motion.y = 0
		$AnimationPlayer.play("boom")

func _cm_end_book () :
	self.queue_free()
