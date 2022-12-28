extends KinematicBody2D

export (int) var scaleX = 1
var maxSpeed            = 25

const gravity                    = 1600
const up                         = Vector2(0, -1)
var motion                       = Vector2(0, 0)

var is_stop = false

func _ready():
	scale.x          = scaleX
	$AnimationPlayer.play("walk")


func _process(delta):
	if not Msgs.in_dialog and not is_stop:
		$AnimationPlayer.play("walk")
		self.motion.y += self.gravity * delta	
		Env.non_use = move_and_slide(self.motion, self.up)
		motion.x = maxSpeed * -1
		
	else :
		motion.x = 0


