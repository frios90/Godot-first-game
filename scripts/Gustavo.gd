extends KinematicBody2D
var floating_text          = preload("res://scenes/FloatingText.tscn")
var ftd                    = 0
const up                   = Vector2(0, -1)
var attack_area_position_y = -43
var attack_area_position_x = -12
var dead_area_position_y   = 2
var dead_area_position_x   = -1
var dead_area_scale_x      = 1
var dead_area_scale_y      = 1.1
var collision_position_x   = 0
var collision_position_y   = 0.5
var collision_scale_x      = 1
var collision_scale_y      = 0.52
var timer_dead             = 0
var time_lapsus_dead       = 150
var motion                 = Vector2(0, 0)
var max_jump               = 2
var times_jump             = 0
var lapsus_step            = 23
var is_healing             = false
var is_jumping             = false
var is_attacking           = false
var is_dashing             = false
var is_hurting             = false
var is_climbing            = false
var going_up               = false
var going_down             = false
var can_pray               = false
var is_praying             = false
var in_hand_pray           = ""
var can_open_chest         = false
var in_front_of_the_chest  = ""
var can_open_door         = false
var can_validate_enter_portal = false
var in_front_of_the_door  = ""

var timer_not_take_damage     = 0
var time_loop_not_take_damage = 60
var timer_pray                = 500

var timer_dash = 0 #PARCHE PARA NO QUEDAR CON EL DASH ACTIVO
var limit_dash = 10 # 40 es 0.6seg aprox -- 5 = 0.15

var event_attack   = 0
var timer_attack   = 0
var limit_attack   = 20

var limit_disabled_collision_down_climb = 10
var timer_disabled_collision_down_climb = 0

var _delta = 0
var state_machine
func _ready():	
	state_machine = $AnimationTree.get("parameters/playback")	
	state_machine.start("idle")
		
func _process(delta):	
	_delta = delta
	if not Players.selected.dead:
		if not Msgs.in_dialog:
			motion.x = 0
			applyItem()
			prayToSave()
			invulnerability()
			if not is_praying and not is_hurting:
				move()
				fall(delta)
				jump()
				attack()
				dash()
				climb()
				Env.non_use = move_and_slide(motion, up)
		else:
			state_machine.travel("idle")
	else:
		timer_dead += 1
		if timer_dead == time_lapsus_dead:
			Players.selected.stats.current_hp = Players.selected.stats.health_points
			Players.selected.stats.current_mp = Players.selected.stats.magic_points
			Players.selected.dead             = false
			if not Players.selected.last_save_point:
				Env.init_position_stage.x = 224
				Env.init_position_stage.y = 904
				Env.non_use               = get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")
			else:
				Players.selected.change_scene_from_dead = true
				Env.non_use = get_tree().change_scene(Players.selected.last_save_point.scene)
				
func invulnerability ():
	if timer_not_take_damage > 0:
		timer_not_take_damage += 1
	if timer_not_take_damage == time_loop_not_take_damage:
		timer_not_take_damage = 0	
		
func climb ():	
	if timer_disabled_collision_down_climb > 0:
		timer_disabled_collision_down_climb += 1
		
	if timer_disabled_collision_down_climb < limit_disabled_collision_down_climb:
		timer_disabled_collision_down_climb = 0
		$CollisionShape2D.disabled = false

	if is_climbing:
		times_jump = 1
		if Input.is_action_pressed("ui_up"):
			state_machine.travel("climb")
			motion.y   = Players.selected.stats.move_speed * -1
			going_up   = true
			going_down = false
		elif Input.is_action_pressed("ui_down"):
			if $Sprite/RayDown.is_colliding():				
				if timer_disabled_collision_down_climb > 0:
					timer_disabled_collision_down_climb = 1
				$CollisionShape2D.disabled = true
			state_machine.travel("climb")
			motion.y = Players.selected.stats.move_speed
			going_up = false
			going_down = true

func fall(delta):	
	if not is_climbing or (not going_down and not going_up):
		motion.y += Players.selected.stats.gravity * Players.selected.stats.mase * delta		
		if is_on_floor():
			times_jump = max_jump
			motion.y  = 0
			is_jumping = false
		if is_on_ceiling():		
			motion.y  += Players.selected.stats.gravity * Players.selected.stats.mase * delta
			is_jumping = false	
	else:
		state_machine.travel("climb-pause")
		motion.y = 0

func move():	
	if not is_attacking:
		if Input.is_action_pressed("ui_right"):

			if not is_jumping:
				state_machine.travel("walk")
			motion.x = Players.selected.stats.move_speed if not is_dashing else Players.selected.stats.dash_speed
			$Sprite.flip_h = false
			$AttackArea/CollisionShape2D.position.x = -8			
		elif Input.is_action_pressed("ui_left"):

			if not is_jumping:
				state_machine.travel("walk")
			motion.x       = -Players.selected.stats.move_speed if not is_dashing else Players.selected.stats.dash_speed * -1
			$Sprite.flip_h = true
			$AttackArea/CollisionShape2D.position.x = -65	
		else:  

			state_machine.travel("idle")	
			motion.x = 0

func applyItem():
	if Input.is_action_just_pressed("useItem") and not is_attacking and not is_jumping and not is_dashing:
		var item = Players.selected.selected_item
		item     = Players.selected.action_items[item]
		item     = Players._get_player_item_by_code(item)
		if item and item.data and item.qty > 0:
			state_machine.travel("health")
			is_healing = true
			Players._set_aura_use_item(self.position)
			Players._use_hp_item(item)
			Players._use_mp_item(item)
			Players._use_tonic(item)

func jump():
	if Input.is_action_just_pressed("jump") and times_jump > 0:
		END_DASH()
		is_jumping = true
		times_jump -= 1
		state_machine.travel("jump")
		motion.y = Players.selected.stats.jump_height
	if Input.is_action_just_released("jump") and motion.y < 0:
		motion.y = 0

func attack():	
	if not can_open_chest and not can_open_door and not can_validate_enter_portal:
		if Players.selected.stats.current_stamine < Players.selected.stats.stamine :
			Players.selected.stats.current_stamine += (Players.selected.stats.stamine_recovery + Players.selected.statuses_stack.stamine.up)
			Util.get_an_script("CanvasLayer").handleSetStamineBar()			
		if is_attacking == true and timer_attack > 0:
			timer_attack += 1
			if timer_attack == limit_attack:
				END_ATTACK(0);
		if Input.is_action_just_pressed("attack") and not is_climbing and timer_attack == 0 and not is_attacking:
			
			if Players.selected.stats.current_stamine >= Players.selected.stats.stamine_cost:
				motion.x = 0
				if event_attack == 0:
					INIT_TRAVEL_ATTACK("attack")
				elif event_attack == 1:	
					INIT_TRAVEL_ATTACK("attack3")
	elif can_open_chest:
		self.openChest(in_front_of_the_chest)
	elif can_open_door:
		self.openDoor(in_front_of_the_door)
	elif can_validate_enter_portal:
		self.enterPortal()

func dash():	
	if is_dashing == true and timer_dash > 0:
		timer_dash += 1
		if timer_dash == limit_dash:
			END_DASH()
	if Input.is_action_just_pressed("dash") and timer_dash == 0 and not is_dashing and not is_jumping and motion.x != 0:		
		INIT_TRAVEL_DASH()

func prayToSave ():
	if Input.is_action_just_pressed("attack") and can_pray and not is_praying:		
		state_machine.travel("pray")
		is_praying = true

func _callMethodFinishPray () :
	if can_pray:
		for pt in SavePoints.points:
			if int(pt.code) == int(in_hand_pray):
				SavePoints.points[pt.key].status = true
				Players.selected.last_save_point = SavePoints.points[pt.key]
		is_praying = false
		
#Area de muerte Gústaf
func _on_DeadArea_area_entered(area):
	if not Players.selected.dead:
		if area.is_in_group("Enemies") and timer_not_take_damage == 0 and area.visible == true:	
			RECIVE_HURT(area)
		elif area.is_in_group("Ladder"):
			is_climbing = true
		elif area.is_in_group("SpikesDead"):
			INSTANT_DEAD()
		elif area.is_in_group("gems"):
			area.get_parent()._gems_pick_up()
			$SoundPickAGem.playing = true
		elif area.is_in_group("Save"):
			in_hand_pray = area.get_parent().spt_code
			can_pray = true
		elif area.is_in_group("Chests"):
			in_front_of_the_chest = area.get_parent().code
			can_open_chest = true
		elif area.is_in_group("Doors"):
			in_front_of_the_door = area.get_parent().code
			can_open_door = true
		elif area.is_in_group("Portal"):
			can_validate_enter_portal = true

func  openChest (chest):
	if Input.is_action_just_pressed("attack") and can_open_chest:
		var key               = Chests._get_chest_by_code(chest).key
		Chests.list[key].open = true

func  openDoor (door):
	if Input.is_action_just_pressed("attack") and can_open_door:
		var door_to_open      = Doors._get_door_by_code(door)
		var has_key           = Players._get_player_item_by_code(door_to_open.for_open_key)
		if has_key:
			Doors.doors[door_to_open.key].open = true
		else:
			if not get_parent().has_node("MsgBoxA"):
				var box = load("res://scenes/GUI/MsgBoxA.tscn")
				box = box.instance()
				box.position.x = self.position.x 
				box.position.y = self.position.y + 50
				get_parent().add_child(box)
				var msg = {
					"issuing" : "System",
					"title"   : "Iglesia",
					"message" : "La puerta esta cerrada con llave",
					"autoclose" : true
				}
				box._unique_event_message(msg)
			else :
				get_parent().get_node("MsgBoxA").queue_free()
			

func  enterPortal ():
	if Input.is_action_just_pressed("attack") and can_validate_enter_portal:

		var has_red     = Players._get_player_item_by_code(1023)
		var has_marron  = Players._get_player_item_by_code(1024)
		var has_blue    = Players._get_player_item_by_code(1025)
		var has_white   = Players._get_player_item_by_code(1026)
#		if has_red and has_marron and has_blue and has_white:
		if 1 > 0 :
			print("ingresar al portar")
			if not Doors.portal.activate:
				get_parent().get_node("Portal/AnimationPlayer").play("open") 
				Doors.portal.activate = true
			else :
				Env.player_origin_position = "init"	
				Env.non_use = get_tree().change_scene("res://scenes/World/Church/church-008-upsidedown.tscn")
		else:
			if not get_parent().has_node("MsgBoxA"):
				var box = load("res://scenes/GUI/MsgBoxA.tscn")
				box = box.instance()
				box.position.x = self.position.x + 100
				box.position.y = self.position.y + 30
				get_parent().add_child(box)
				var msg = {
					"issuing" : "System",
					"title"   : "Portal",
					"message" : "debes tener todos los fragmentos para activar el portal.",
					"autoclose" : true
				}
				box._unique_event_message(msg)
			else :
				get_parent().get_node("MsgBoxA").queue_free()
			
func _on_DeadArea_area_exited(area):
	if area.is_in_group("Ladder"):
		is_climbing = false
		going_down  = false
		going_up    = false
		motion.y += Players.selected.stats.gravity * Players.selected.stats.mase * _delta
	elif area.is_in_group("Save"):
		can_pray = false
	elif area.is_in_group("Chests"):
		can_open_chest = false
	elif area.is_in_group("Doors"):
		can_open_door = false

func _on_AttackArea_area_entered(area):
	if not Players.selected.dead:
		if area.is_in_group("EnemiesDefense"):
			self.call_deferred("_call_deferred_attack", true)

func _call_deferred_attack(status):
	$AttackArea/CollisionShape2D.disabled = status

func _callMethodFinishAttack () :
	END_ATTACK(1);

func _callMethodFinishAttack3 ():
	END_ATTACK(0);

func _callMethodFinishDash () :
	END_DASH()	

func _callMethodFinishHeath () :
	self.is_healing = false	
	
func _callMethodFinishHurt () :
	is_hurting = false
	
func INIT_TRAVEL_ATTACK (travel_to = "attack"):
	
	is_attacking = true		
	timer_attack = 1
	state_machine.travel(travel_to)
	Players.selected.stats.current_stamine = Players.selected.stats.current_stamine - Players.selected.stats.stamine_cost
	Util.get_an_script("CanvasLayer").handleSetStamineBar()
	$AttackArea/CollisionShape2D.disabled = false

func INIT_TRAVEL_DASH ():
	is_dashing = true	
	timer_dash = 1	
	state_machine.travel("dash")
	$CollisionShape2D.position.x          = 0
	$CollisionShape2D.position.y          = 26
	$CollisionShape2D.scale.x             = 2
	$CollisionShape2D.scale.y             = 0.15	
	$DeadArea/CollisionShape2D.position.x = 3
	$DeadArea/CollisionShape2D.position.y = 17
	$DeadArea/CollisionShape2D.scale.x    = 5
	$DeadArea/CollisionShape2D.scale.y    = 0.3	

func END_ATTACK (to_attack = 0) :
	is_attacking   = false
	event_attack = to_attack
	timer_attack   = 0
	$AttackArea/CollisionShape2D.disabled = true

func END_DASH ():
	timer_dash  = 0
	is_dashing  = false		
	$CollisionShape2D.position.x          = collision_position_x
	$CollisionShape2D.position.y          = collision_position_y
	$CollisionShape2D.scale.x             = collision_scale_x
	$CollisionShape2D.scale.y             = collision_scale_y		
	$DeadArea/CollisionShape2D.position.x = dead_area_position_y 
	$DeadArea/CollisionShape2D.position.y = dead_area_position_x
	$DeadArea/CollisionShape2D.scale.x    = dead_area_scale_x
	$DeadArea/CollisionShape2D.scale.y    = dead_area_scale_y	

		
func RECIVE_HURT (area):	
	state_machine.travel("hurt")
	$SoundHurt.play()
	is_hurting            = true	
	timer_not_take_damage = 1
	Players.selected.stats.current_hp -= Util.apply_damage_body(area.get_parent().attack, Players._get_defense())	
	Util.get_an_script("CanvasLayer").handleSetHpBar()					
	if Players.selected.stats.current_hp <= 0:
		$SoundDead.playing = true
		state_machine.travel("death")
		Players.selected.dead = true

func INSTANT_DEAD ():	
	Players.selected.stats.current_hp -= Players.selected.stats.current_hp	
	Util.get_an_script("CanvasLayer").handleSetHpBar()
	$SoundDead.playing = true
	state_machine.travel("death")
	Players.selected.dead = true	

func _increment_exp_player(points):
	Players.selected.stats.experience += points
	while  Players.selected.stats.experience >=  Players.selected.stats.next_level:
		Players.selected.stats.level     += 1
		Players.selected.stats.next_level =  Players.selected.stats.next_level *  Players.selected.stats.level * Players.selected.increase_level
		Players.selected.stats.strength   =  Players.selected.stats.strength + ( Players.selected.stats.level *  Players.selected.increase_stats)
		var lvlUP = load("res://scenes/Players/LevelUp.tscn")		
		lvlUP = lvlUP.instance()
		lvlUP.position.y = lvlUP.position.y -2
		self.get_node("Sprite").call_deferred("add_child",lvlUP)
		yield(get_tree().create_timer(1), "timeout")	
		lvlUP.queue_free()
		Util.get_an_script("CanvasLayer").handleSetLevelInUiPlayer()
