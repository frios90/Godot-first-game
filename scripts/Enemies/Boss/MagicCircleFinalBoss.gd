extends KinematicBody2D

var speed = 5
var grow  = 0.002

func _ready():
	$MagicCircle.scale.x = 0.01
	$MagicCircle.scale.y = 0.01

func _process(_delta):	
	if grow > 0 and speed > 0:
		$MagicCircle.scale.x = 	$MagicCircle.scale.x + grow
		$MagicCircle.scale.y = 	$MagicCircle.scale.y + grow
		$MagicCircle.rotation_degrees += speed
		if int($MagicCircle.rotation_degrees) >= 720:
			$MagicCircle.rotation = 0
			grow = 0
			speed = 0
			self.queue_free()
