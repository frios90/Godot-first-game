extends KinematicBody2D

export (int) var gravity = 500
const maxSpeed   = 26

const up         = Vector2(0, -1)
const ptsDead    = 300
var life         = 10
var attack       = 2 
var dead         = false
var motion       = Vector2(0, 0)
var is_dead      = false
var is_attacking = false
var useRandSound = 0

func _ready():
	$Animations.scale.x = -1
	$Animations.play("Walk")
	motion.x = -maxSpeed		
	pass
		
func _next_to_left_wall() -> bool:
	return $LeftRay.is_colliding()
	
func _next_to_right_wall() -> bool:
	return $RightRay.is_colliding()
	
func _floor_detection() -> bool:
	return $Animations/FloorDetectionRay.is_colliding()
	
func _flip():
	if _next_to_left_wall() or _next_to_right_wall() or _floor_detection() == false:
		motion.x *= -1
		$Animations.scale.x *= -1

func _process(delta):
	if not dead:		
		motion.y += gravity	* delta	
		_flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)
		
	move_and_slide(motion, up)

func _on_KillArea_area_entered(area):
	if area.is_in_group("Sword"):		
		applySoundSword()			
		if (dead == false):
			life = life - Env.attack
			$Animations.play("Hurt")
		if life <= 0:
			if (dead == false):
				dead =  true			
				$Animations.play("Killed")
				var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
				canvasLayer.handleIncrementExp(ptsDead)
		
func applySoundSword ():
	if useRandSound == 0:
		$DamageSwordSound.playing  = true
	else:
		$DamageSwordSound2.playing  = true


func _on_Animations_animation_finished():
	if $Animations.animation == "Killed":
		queue_free()
	if $Animations.animation == "Hurt":
		$Animations.play("Walk")


	

