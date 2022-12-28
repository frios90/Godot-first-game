extends KinematicBody2D

func _ready():
	var timer_aura = get_tree().create_timer(0.5)
	timer_aura.connect("timeout", self, "_end_aura")	

func _end_aura ():
	self.queue_free()
