extends KinematicBody2D

const moveSpeed  = 170
const maxSpeed   = 140
const dashSpeed   = 135
const jumpHeight = -450
const GRAVITY    = 1500

var collision_position_x = 0
var collision_position_y = 0
var collision_scale_x = 1.6
var collision_scale_y = -0.45

const UP         = Vector2(0, -1)
var dead   = false
var timer_dead = 0
var ATTACK = 0
var motion = Vector2(0, 0)

var max_jump = 1
var times_jump = 0
var lapsus_step = 23

var is_attacking = false
var is_jumping = false
var is_dashing = false
	
var state_machine
var timer_sount_walk = 0

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	
		
func _process(delta):	
	if not dead:
		motion.x = 0
		fall(delta)
		move()	
		jump()
		attack()
		dash()
		move_and_slide(motion, UP)
	else:		
		timer_dead += 1
		if timer_dead == 100:	
			Env.current_life = Env.life
			get_tree().reload_current_scene()

func fall(delta):	
	motion.y += GRAVITY * delta	
	if is_on_floor():
		times_jump = max_jump
		motion.y = 0
		is_jumping = false
	if is_on_ceiling():
		motion.y += GRAVITY* 3 * delta
		is_jumping = false	

func move():	

		
	if Input.is_action_pressed("ui_right"):	
		motion.x = moveSpeed + ATTACK
		state_machine.travel("walk")
		$Sprite.flip_h = false
		$AttackArea/CollisionShape2D.position.x = -8
		if timer_sount_walk == lapsus_step:
			$SoundWalk.playing  = true
			timer_sount_walk = 0
		elif timer_sount_walk == 0:
			$SoundWalk.playing  = true
		timer_sount_walk += 1
		
	

	elif Input.is_action_pressed("ui_left"):
		motion.x = -moveSpeed + ATTACK
		state_machine.travel("walk")
		$Sprite.flip_h = true
		$AttackArea/CollisionShape2D.position.x = -65
		if timer_sount_walk == lapsus_step:				
			$SoundWalk.playing  = true
			timer_sount_walk = 0
		elif timer_sount_walk == 0:
			$SoundWalk.playing  = true			
		timer_sount_walk += 1
	
	else:  
		state_machine.travel("idle")			
		motion.x = 0
	
func dash():	
	if Input.is_action_pressed("dash"):
		$SoundWalk.playing  = false
		timer_sount_walk    = 0
		state_machine.travel("dash")	
		$CollisionShape2D.position.x = 1
		$CollisionShape2D.position.y = 16
		$CollisionShape2D.scale.x    = 4
		$CollisionShape2D.scale.y    = 0.1		
	if Input.is_action_just_released("dash"):			
		$CollisionShape2D.position.x = collision_position_x
		$CollisionShape2D.position.y = collision_position_y
		$CollisionShape2D.scale.x    = collision_scale_x
		$CollisionShape2D.scale.y    = collision_scale_y	
		
func jump():
	
	if Input.is_action_just_pressed("jump") and times_jump > 0:
		$SoundWalk.playing  = false
		timer_sount_walk    = 1
		times_jump -= 1
		state_machine.travel("jump")			
		motion.y = jumpHeight
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = 0
		
func attack():
	
	if Input.is_action_just_pressed("attack") :
		$SoundWalk.playing  = false
		timer_sount_walk    = 0
		state_machine.travel("attack")
		$AttackArea/CollisionShape2D.disabled = false
	elif Input.is_action_just_released("attack") :
		state_machine.travel("attack")
		$AttackArea/CollisionShape2D.disabled = true
	
		
#acumular monedas
func addCoin():	
	$SoundWalk.playing  = false
	timer_sount_walk    = 0
	var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
	canvasLayer.handleCoinCollected()

#Area de muerte Gústaf
func _on_DeadArea_area_entered(area):
	if not dead:
		if area.is_in_group("Enemies"):		
			Env.current_life -= area.get_parent().attack		
			state_machine.travel("hurt")
			var hp_bar = (float(100) / float(Env.life)) * float(Env.current_life)
			var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
			canvasLayer.handleSetHpBar()				
			if Env.current_life <= 0:
				$AnimationPlayer.play("death")
				dead = true


