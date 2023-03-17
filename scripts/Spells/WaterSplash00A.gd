extends KinematicBody2D

func _cm_finish ():
	self.queue_free()
