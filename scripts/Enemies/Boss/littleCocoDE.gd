extends KinematicBody2D

var mx = 100
const gravity    = 500
const up         = Vector2(0, -1)
const ptsDead    = 50
var life         = 2
var attack       = 2
var dead         = false
var motion       = Vector2(0, 0)
var is_dead      = false
var is_attacking = false
var useRandSound = 0
var timer_to_dead = 0
var timer_to_flip = 0


func _ready():	
	$AnimationPlayer.play("little-attack")
	motion.x = 0	
	pass
	


func _process(_delta):	
	move_and_slide(motion, up)


func applySoundSword ():
	if useRandSound == 0:
		$DamageSwordSound.playing  = true
		$DamageSwordSound2.playing  = false
	else:
		$DamageSwordSound.false  = true
		$DamageSwordSound2.playing  = true

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):	
		applySoundSword()				
		get_parent().get_parent().visible = false
		$DeadArea.visible = false

				
