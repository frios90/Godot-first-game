extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 5
var grow  = 0.002

func _ready():
	$MagicCircle.scale.x = 0.01
	$MagicCircle.scale.y = 0.01
	pass # Replace with function body.

func _process(delta):
	
	if grow > 0 and speed > 0:
		print($MagicCircle.rotation)
		$MagicCircle.scale.x = 	$MagicCircle.scale.x + grow
		$MagicCircle.scale.y = 	$MagicCircle.scale.y + grow
		$MagicCircle.rotation_degrees += speed
	
		print($MagicCircle.rotation_degrees)
		if int($MagicCircle.rotation_degrees) >= 720:
			$MagicCircle.rotation = 0
			grow = 0
			speed = 0
			self.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
