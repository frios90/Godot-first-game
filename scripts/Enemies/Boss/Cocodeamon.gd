extends KinematicBody2D
export (int) var mx = 100
export (int) var flipTime = 100 
const maxSpeed   = 270
const up         = Vector2(0, -1)
const ptsDead    = 3000
const life       = 200
var current_life = life
var attack       = 2
var dead         = false
var motion       = Vector2(0, 0)
var is_dead      = false
var is_attacking = false
var useRandSound = 0
var timer_to_dead = 0
var timer_to_flip = 0
var timer_not_take_damage = 0
var time_loop_not_take_damage = 60

var limit_move_y = -8
var move_y = -2

var collider
var state_machine

var n = 150
var flp = "v"
var old_x = 120
var old_y = -50

var type_flip = 1

var timer_up_down = 0
var limit_up_down = 10
var go_up         = 1

var incrementSize = false
var cont_hit_damage = 0

func _ready():	
	if not dead:
		state_machine = $AnimationTree.get("parameters/playback")
		state_machine.start("idle")
		motion.x = maxSpeed
			

func _collision_R () -> bool:
	return $RayCollR.is_colliding()
	
func _collision_L () -> bool:
	return $RayCollL.is_colliding()

func _turnBack():
	if _collision_R() or _collision_L():	
		if (timer_up_down < limit_up_down):
			timer_up_down += 1
		else:
			motion.y = 0
			go_up *= -1
			timer_up_down = 0		
		if go_up > 0:
			motion.y += -1
		else:
			motion.y += 1
		motion.x *= -1
		$Sprite.scale.x *= -1


	
func _process(_delta):	
	_turnBack()
	_incrementSize()
	invulnerability()	
	if not dead:	
		state_machine.travel("idle")	
		motion.y += 0
		if is_on_floor():
			motion.y = 0
		
		move_and_slide(motion, up)
	else:
		AnimationTree.ANIMATION_PROCESS_MANUAL
		$AnimationPlayer.play("dead")
		timer_to_dead += 1
		move_and_slide(Vector2(0, 20), up)
		if timer_to_dead == 100:

			queue_free()		

func invulnerability ():
	if timer_not_take_damage > 0:			
		timer_not_take_damage += 1			
	if timer_not_take_damage == time_loop_not_take_damage:
		$CollisionShape2D.disabled =false
		$Sprite/DeadArea.visible = true
		$Sprite/DeadArea/CollisionShape2D.disabled = false
	
		timer_not_take_damage = 0	
	
func _incrementSize () :
	if cont_hit_damage == 7:
		cont_hit_damage += 1
		incrementSize = true
	elif cont_hit_damage == 14:
		cont_hit_damage += 1
		incrementSize = true
	elif cont_hit_damage == 21:
		cont_hit_damage += 1
		incrementSize = true
	elif cont_hit_damage == 28:
		cont_hit_damage += 1
		incrementSize = true
	elif cont_hit_damage == 35:
		cont_hit_damage += 1
		incrementSize = true
	else:
		incrementSize = false
	
	if incrementSize == true:
		$Sprite.scale.x *= 1.1
		$Sprite.scale.y *= 1.1
		incrementSize = false

func applySoundSword ():
	if useRandSound == 0:
		$DamageSwordSound.playing  = true
	else:
		$DamageSwordSound2.playing  = true

func _on_DeadArea_area_entered(area):
	if not dead:
		if area.is_in_group("Sword") and timer_not_take_damage == 0:
			applySoundSword()
			$HurtSound.playing = true
			cont_hit_damage +=1
			state_machine.travel("hurt")
			timer_not_take_damage = 1
			$CollisionShape2D.disabled =true
			$Sprite/DeadArea.visible = false
			$Sprite/DeadArea/CollisionShape2D.disabled = true
			
			current_life = current_life - Env.attack
			var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
			canvasLayer.handleUpdateHpBarBoss()
			
		if current_life <= 0:
			if not dead:	
				var cv = get_tree().get_root().find_node("CanvasLayer", true,false)
				cv.handleFinishFigthingBoss()
				dead =  true
				AnimationTree.ANIMATION_PROCESS_MANUAL
				cv.handleIncrementExp(ptsDead)
				var player = get_parent().get_node("knight").pray()
		

