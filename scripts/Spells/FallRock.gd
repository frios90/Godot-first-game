extends KinematicBody2D
const gravity                    = 250
var speed = 5
var motion                       = Vector2(0, 0)
const up                         = Vector2(0, -1)
var attack = 30


func _process(delta):	
	self.motion.y += gravity * delta
	if self.speed > 0:
		$Sprite.rotation_degrees += self.speed
	
	self.boom()
	Env.non_use = move_and_slide(motion, up)


func boom () :
	if $RayBoom.is_colliding() or $RayBoom3.is_colliding() or $RayBoom4.is_colliding():		
		self.motion.y = 0
		$Sprite.rotation_degrees = 0
		$AnimationPlayer.play("boom")
		

func _cm_end_book () :
	self.queue_free()
