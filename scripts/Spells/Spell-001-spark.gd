extends KinematicBody2D

var is_action       = false
var attack          = 0
onready var element = "thunder"

func _ready():	 
	$AnimationPlayer.play("action")

func _callMethodInitAction ():
	self.queue_free()

func _callMethodFinishAction ():
	self.queue_free()
