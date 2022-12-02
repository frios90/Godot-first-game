extends KinematicBody2D

const moveSpeed  = 195
const dashSpeed   = 600
const jumpHeight = -890
const gravity    = 1400
const mase       = 1.8      

var attack_area_position_y = -43
var attack_area_position_x = -12

var dead_area_position_y = 2
var dead_area_position_x = -1
var dead_area_scale_x = 1
var dead_area_scale_y = 1

var collision_position_x = 0
var collision_position_y = 0.5
var collision_scale_x = 1
var collision_scale_y = 0.5

const UP             = Vector2(0, -1)
var dead             = false
var timer_dead       = 0
var time_lapsus_dead = 150

var motion = Vector2(0, 0)

var max_jump = 1
var times_jump = 0
var lapsus_step = 23

var is_healing = false
var is_jumping = false
var is_attacking = false
var is_dashing = false
var is_air_attack = 0 # 0=>false, 1=> attack, 2=>impact
var is_climbing = false

var going_up = false

var animation
var state_machine

var timer_not_take_damage = 0
var time_loop_not_take_damage = 60
var timer_pray = 500

var timer_dash = 0 #PARCHE PARA NO QUEDAR CON EL DASH ACTIVO
var limit_dash = 15 # 40 es 0.6seg aprox -- 5 = 0.15

var current_attack = 0
var timer_attack   = 0
var limit_attack   = 20
var anim

func _ready():
	animation = get_node("AnimationPlayer")
	print(animation)
	state_machine = $AnimationTree.get("parameters/playback")	
	state_machine.start("idle")
		
func _process(delta):	
	if not dead:			
		motion.x = 0
		health()
		fall(delta)
		
		if not is_healing:
			move()	
			climb()
			jump()
			attack()
			dash()
			airAttack()
			move_and_slide(motion, UP)
		invulnerability()	

		
	else:		
		timer_dead += 1
		if timer_dead == time_lapsus_dead:	
			Env.current_life = Env.life
			var restart = get_tree().reload_current_scene()

func invulnerability ():
	if timer_not_take_damage > 0:			
		timer_not_take_damage += 1			
	if timer_not_take_damage == time_loop_not_take_damage:
		timer_not_take_damage = 0	
func climb ():
	if is_climbing:
		if Input.is_action_pressed("ui_up"):
			state_machine.travel("climb")
			print("deberia subir")
		
	
func fall(delta):	
	motion.y += gravity * mase * delta	
	if is_on_floor():
		times_jump = max_jump
		motion.y = 0
		is_jumping = false
	if is_on_ceiling():
		motion.y += gravity * mase * delta
		is_jumping = false	

func move():	
	if Input.is_action_pressed("ui_right"):
		state_machine.travel("walk")
		motion.x = moveSpeed if not is_dashing else dashSpeed
		$Sprite.flip_h = false
		$AttackArea/CollisionShape2D.position.x = -8
		
	elif Input.is_action_pressed("ui_left"):
		state_machine.travel("walk")
		motion.x = -moveSpeed if not is_dashing else dashSpeed * -1
		$Sprite.flip_h = true
		$AttackArea/CollisionShape2D.position.x = -65	
	else:  
		state_machine.travel("idle")	
		motion.x = 0

func health():
	if Input.is_action_just_pressed("health") and not is_attacking and not is_jumping and not is_dashing and not is_air_attack:
		print("HEALTH")

		if Env.current_potions > 0:
			is_healing = true
			Env.current_potions -= 1

			state_machine.travel("health")	
			Env.current_life += Env.recovery_potion
			Env.current_life = Env.current_life if Env.current_life <= Env.life else Env.life
			var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
			canvasLayer.handleSetHpBar()
			canvasLayer.handleUploadPotas()

		
func jump():
	if Input.is_action_just_pressed("jump") and times_jump > 0:
		is_jumping = true
		times_jump -= 1
		state_machine.travel("jump")
		motion.y = jumpHeight
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = 0
	
func attack():	
	if is_attacking == true and timer_attack > 0:
		timer_attack += 1
		if timer_attack == limit_attack:
			END_ATTACK(0);			
	if Input.is_action_just_pressed("attack") and timer_attack == 0 and not is_attacking:
		if current_attack == 0:		
			INIT_TRAVEL_ATTACK("attack")			
		elif current_attack == 1:	
			INIT_TRAVEL_ATTACK("attack3")

func airAttack ():
	if is_jumping == true:
		if Input.is_action_just_pressed("air-attack") :				
			is_air_attack = 1		
			state_machine.travel("air-attack")	
			$AttackArea/CollisionShape2D.disabled = false
			$AttackArea/CollisionShape2D.position.x = -27
			$AttackArea/CollisionShape2D.position.y = -35			
			$CollisionShape2D.position.x = 1		
			
func dash():	
	if is_dashing == true and timer_dash > 0:
		timer_dash += 1
		if timer_dash == limit_dash:
			END_DASH()

	if Input.is_action_just_pressed("dash") and timer_dash == 0 and not is_dashing and not is_jumping and motion.x != 0:		
		INIT_TRAVEL_DASH()

	

func pray ():
	state_machine.travel("pray")

func _callMethodFinishAttack () :
	END_ATTACK(1);

func _callMethodFinishAttack3 ():
	END_ATTACK(0);
	
func _callMethodFinishAirAttack ():
	is_attacking = false
	$AttackArea/CollisionShape2D.position.x = attack_area_position_x
	$AttackArea/CollisionShape2D.position.y = attack_area_position_y			
	$AttackArea/CollisionShape2D.disabled = true

func _callMethodFinishAirAttackImpact ():
	is_attacking = false
	$AttackArea/CollisionShape2D.position.x = attack_area_position_x
	$AttackArea/CollisionShape2D.position.y = attack_area_position_y			
	$AttackArea/CollisionShape2D.disabled = true
	
func _callMethodFinishDash () :
	END_DASH()	

func _callMethodFinishHeath () :
	is_healing = false	
	
func INIT_TRAVEL_ATTACK (travel_to = "atttack"):
	is_attacking = true		
	timer_attack = 1
	state_machine.travel(travel_to)
	$AttackArea/CollisionShape2D.disabled = false

func INIT_TRAVEL_DASH ():
	is_dashing = true	
	timer_dash = 1	
	state_machine.travel("dash")
	$CollisionShape2D.position.x = 0
	$CollisionShape2D.position.y = 26
	$CollisionShape2D.scale.x    = 2
	$CollisionShape2D.scale.y    = 0.15	
	$DeadArea/CollisionShape2D.position.x = 3
	$DeadArea/CollisionShape2D.position.y = 17
	$DeadArea/CollisionShape2D.scale.x    = 5
	$DeadArea/CollisionShape2D.scale.y    = 0.3	

func END_ATTACK (to_attack = 0) :
	is_attacking = false
	current_attack = to_attack
	timer_attack = 0
	$AttackArea/CollisionShape2D.disabled = true

func END_DASH ():
	timer_dash = 0
	is_dashing = false		
	$CollisionShape2D.position.x = collision_position_x
	$CollisionShape2D.position.y = collision_position_y
	$CollisionShape2D.scale.x    = collision_scale_x
	$CollisionShape2D.scale.y    = collision_scale_y		
	$DeadArea/CollisionShape2D.position.x = dead_area_position_y 
	$DeadArea/CollisionShape2D.position.y = dead_area_position_x
	$DeadArea/CollisionShape2D.scale.x = dead_area_scale_x
	$DeadArea/CollisionShape2D.scale.y = dead_area_scale_y	
#acumular monedas
func addCoin():	
	var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
	canvasLayer.handleCoinCollected()

#Area de muerte Gústaf
func _on_DeadArea_area_entered(area):
	if not dead:		
		print(area.get_name())
		if area.is_in_group("Enemies") and timer_not_take_damage == 0 and area.visible == true:
			print(area.visible)
			var enemyAttack = area.get_parent().get_parent().attack
			if is_air_attack == 1:
				enemyAttack *= Env.low_damage_air_attack
			timer_not_take_damage = 1
			Env.current_life -= enemyAttack	
			state_machine.travel("hurt")
			$SoundHurt.play()		
#
			var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
			canvasLayer.handleSetHpBar()				
			if Env.current_life <= 0:
				motion.y -= 1500
				$SoundDead.playing = true
				$AnimationPlayer.play("death")				
				dead = true	
				
		elif area.is_in_group("Ladder"):
			is_climbing = true
			print("en la escalera")
		
func _on_AttackArea_area_entered(area):
	if not dead:
		if area.is_in_group("Enemies"):
			if is_air_attack == 1:
				Env.attack *= Env.plus_air_attack
				is_air_attack = 2
				$AnimationPlayer.play("air-attack-impact")			
			Env.attack = Env.memory_attack
			$AttackArea/CollisionShape2D.disabled = true



func _on_DeadArea_area_exited(area):
	if area.is_in_group("Ladder"):
		is_climbing = false
		print("Sali de la la escalera")
