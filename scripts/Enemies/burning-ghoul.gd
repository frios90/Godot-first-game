extends KinematicBody2D

export (int) var level  = 1
export (int) var scaleX = -1
export (int) var withMoveAndFlip = 1
export (int) var maxSpeed = 160

const gravity    = 1600
const up         = Vector2(0, -1)
const ptsDead    = 300

var dead         = false

var life         = 220
var current_life = 150
var base_attack  = 30
var base_defense = 10
var attack       = base_attack if level == 1 else base_attack * (level * 0.77)
var defense      = base_defense if level == 1 else base_defense * (level * 0.55)

var motion = Vector2(0, 0)

var is_attacking  = true
var useRandSound = 0

func _ready():
	
	attack       = base_attack if level == 1 else base_attack * (level * 0.77)
	defense      = base_defense if level == 1 else base_defense * (level * 0.55)
	current_life = life if level == 1 else life * (level * 0.77)
	
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = life if level == 1 else life * (level * 0.77)
	
	scale.x = scaleX
	$AnimationPlayer.play("attack")
	if withMoveAndFlip == 1:
		motion.x = maxSpeed * scaleX
	else:
		motion.x = 0		
	
func _process(delta):	

	if not dead:	
		motion.y += gravity	* delta
		flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	move_and_slide(motion, up)
		
func flip():
	if withMoveAndFlip == 1 :
		if $RayFront.is_colliding() or $RayFlip.is_colliding() or $RayEnd.is_colliding() == false:
			motion.x *= -1
			scale.x  *= -1

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):
		Util.get_an_script("Camera2D").trauma = true
		applySoundSword()			
		if (dead == false):
			current_life = current_life - Players._get_attack()
			$HPbar.value = current_life
		if current_life <= 0:
			if (dead == false):
				dead =  true
				$AnimationPlayer.play("dead")
				Util.get_an_script("CanvasLayer").handleIncrementExp(ptsDead)

func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
func _callMethodFinishDead ():
	queue_free()
