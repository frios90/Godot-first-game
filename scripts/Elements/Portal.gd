extends KinematicBody2D

func _process(delta):
	if Doors.portal.activate:
		$AnimationPlayer.play("on") 
