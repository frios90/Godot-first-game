extends KinematicBody2D

export (int) var scaleX = 1
var maxSpeed            = 25

const gravity = 1600
const up      = Vector2(0, -1)
var motion    = Vector2(0, 0)
var speed     = 60

func _ready():
	scale.x          = scaleX
	$AnimationPlayer.play("idle")

func _process(delta):
	if not Msgs.in_dialog:
		self.motion.y += self.gravity * delta	
		Env.non_use = move_and_slide(self.motion, self.up)

func go_on (side) :	
	$AnimationPlayer.play("walk")
	if side == "L":
		self.motion.x = self.speed * -1
		yield(get_tree().create_timer(3), "timeout")	
		self.call_deferred("call_defered_bay")
	if side == "R":
		self.motion.x = self.speed
		self.scale.x *=-1
		yield(get_tree().create_timer(3), "timeout")	
		self.call_deferred("call_defered_bay")

func call_defered_bay () :
	self.queue_free()	

func dead ():
	var blood = load("res://scenes/Spells/Blood.tscn")
	blood = blood.instance()
	add_child(blood)
	DbBoss.old_man.dead = true


	var blood3 = load("res://scenes/Spells/Blood.tscn")
	blood3 = blood3.instance()
	blood3.position.x += 10
	blood3.position.y += 20
	add_child(blood3)

