extends KinematicBody2D

export (int) var mx = 100
export (int) var flipTime = 150 

const maxSpeed   = 150
const gravity    = 500
const up         = Vector2(0, -1)
const ptsDead    = 100
var life         = 4
var attack       = 1
var dead         = false
var motion       = Vector2(0, 0)
var is_dead      = false
var is_attacking = false
var useRandSound = 0
var timer_to_dead = 0
var timer_to_flip = 0
func _ready():	
	$AnimationPlayer.play("fly")
	motion.x = mx	
	pass
	
func _flip():
	
	if timer_to_flip == flipTime:
		motion.x *= -1
		$Sprite.scale.x *= -1
		timer_to_flip = 0
	timer_to_flip += 1

func _process(_delta):
	_flip()
	
	if not dead:		
		motion.y += 0
		if is_on_floor():
			motion.y = 0
	else:
		timer_to_dead += 1	
		motion = Vector2(0, 0)
		if timer_to_dead == 15:
			queue_free()		
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
		if (dead == false):
			life = life - Env.attack
		if life <= 0:
			if (dead == false):				
				dead =  true
				var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
				canvasLayer.handleIncrementExp(ptsDead)
					
				
