extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
const gravity                    = 1600
const ptsDead                    = 120
const up                         = Vector2(0, -1)

var level           = 1

var dead                         = false 
var life                         = DbBoss.water_spirit.life
var maxSpeed                     = 450

var withMoveAndFlip = 0

var base_attack                  = DbBoss.water_spirit.base_attack
var base_defense                 = DbBoss.water_spirit.base_defense
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)


var to_jump       = 1
var count_to_jump = 0
var in_jump = false

var to_dive       = 2
var count_to_dive = 0
var in_dive = false

var state_machine
var dir_attacks = 1
var power_shoot  = 70
var speed_shoot = 250
var hits_to_charge       = 2
var count_hits_to_charge = 0




var in_bump_rocks = false

var to_flip       = 1
var count_to_flip = 0

var to_leave_bump_rocks = 3
var count_to_leave_bump_rocks = 0

var to_fall_rocks       = 1
var count_to_fall_rocks = 0
var in_fall_rocks       = false


var in_wall_rocks       = false

func _ready():		
	Util.get_an_script("CanvasLayer").get_node("BossBarControl/HPBarBoss").value = DbBoss.water_spirit.life
	self.state_machine = $AnimationTree.get("parameters/playback")
	self.state_machine.start("idle")
	$AttackArea/CollisionShape2D.disabled = true
	$ChargeArea/CollisionShape2D.disabled = true

#func _process(delta):
#	self._delta = delta
#	if not DbBoss.water_spirit.dead:	
#		self.motion.y += gravity * delta		
#		charge()
#		flip()
#		if not self.in_jump and not self.in_dive:
#			moveOrIdle()
#			dive()
#			attacking()
##			waterShot()
#		if is_on_floor():
#			self.motion.y = 0
#	else:
#		$ChargeArea/CollisionShape2D.disabled = true
#		$DeadArea/CollisionShape2D.disabled   = true
#		$AttackArea/CollisionShape2D.disabled = true
#		self.state_machine.travel("dead")
#		self.motion = Vector2(0, 0)	
#
#	Env.non_use = move_and_slide(motion, up)
		
func moveOrIdle():
	if withMoveAndFlip == 1:
		self.state_machine.travel("walk")
		self.motion.x = maxSpeed * -1
	else:
		self.state_machine.travel("idle")
		self.motion.x = 0
		
func flip():
	if $RayFlip.is_colliding():
		self.count_to_flip    +=1
		self.maxSpeed         *= -1
		self.scale.x          *= -1
		self.motion.x          = self.maxSpeed
		self.dir_attacks      *= -1
		self.speed_shoot      *= -1
		self.count_to_jump += 1			

func jump () :
	var jump_splash = load("res://scenes/Spells/WaterSplash00A.tscn")
	jump_splash = jump_splash.instance()
	jump_splash.position.x = self.position.x
	jump_splash.position.y = self.position.y  -200
	get_parent().add_child(jump_splash)
	$CollisionShape2D.disabled = true
	$ChargeArea/CollisionShape2D.disabled = true
	$DeadArea/CollisionShape2D.disabled   = true
	$AttackArea/CollisionShape2D.disabled = true
		
	self.in_jump = true
	self.in_dive = false
	
	self.state_machine.travel("jump")
	self.motion.y = -1000
	self.motion.x = 0
	$RayFlip.enabled = false
	Env.non_use = move_and_slide(motion, up)
	

func _cm_finish_jump ():
	self.in_jump = false
	$CollisionShape2D.disabled = false
	$ChargeArea/CollisionShape2D.disabled = false
	$DeadArea/CollisionShape2D.disabled   = false


func dive ():
	if $RayDive.is_colliding() or self.count_to_dive == self.to_dive:
		motion.x = 0		
		if self.count_to_dive == self.to_dive:
			self.count_to_dive = 0	
		state_machine.travel("dive")	
		$CollisionShape2D.disabled = true
		$DeadArea/CollisionShape2D.disabled = true
		$RayDive.enabled = false
		$RayAttack.enabled = false
		

func _cm_finish_dive ():

	self.in_dive = true
	$RayFlip.enabled = true
	$RayAttack.enabled = true
	$CollisionShape2D.disabled = false
	$DeadArea/CollisionShape2D.disabled = false
	_wave(-50, false)
	_wave(500, true)

func _wave (plus_x, invert_dir) :
	var wave = load("res://scenes/Spells/Wave.tscn")
	wave = wave.instance()
	wave.position.x = self.position.x + ((plus_x) * self.dir_attacks) 
	wave.position.y = self.position.y + 46
	
	var event_dir = self.dir_attacks if not invert_dir else self.dir_attacks *-1
	wave.scale.x    = event_dir
	wave.speed      = wave.speed * event_dir 
	get_parent().add_child(wave)
	
	
func attacking () :
	if $RayAttack.is_colliding() and not self.in_dive:		
		motion.x = 0
		state_machine.travel("attack")	
		self.count_to_leave_bump_rocks = 0

func _cm_init_attack () :
	$AttackArea/CollisionShape2D.disabled   = false
	$RayDive.enabled = true

func _cm_end_attack () :
	$AttackArea/CollisionShape2D.disabled   = true
		



		
func wallRocks () :
	if self.to_wall_rocks == self.count_to_wall_rocks:		
		state_machine.travel("WallRocks")
		self.in_wall_rocks = true		
	
func charge () :
	if self.in_dive:
		$RayFlip.enabled = true
		state_machine.travel("charge")	
		self.motion.x = self.maxSpeed
		if self.count_to_flip >= self.to_flip:
			self.count_to_flip = 0
			self.count_hits_to_charge = 0
			$ChargeArea/CollisionShape2D.disabled = true
			$DeadArea/CollisionShape2D.disabled   = false			
			self.jump()

func waterShot () :
	if $RayWaterShot.is_colliding():
		motion.x = 0
		state_machine.travel("ice")
			
func _call_bumrock () :
	var bumprock = load("res://scenes/Spells/BumpRock.tscn")
	bumprock = bumprock.instance()
	bumprock.position.x = self.position.x + (50 * self.dir_attacks)
	bumprock.position.y = self.position.y + 46
	bumprock.scale.x    = self.dir_attacks
	bumprock.speed      = bumprock.speed * self.dir_attacks 
	get_parent().add_child(bumprock)
	self.count_to_leave_bump_rocks += 1
	self.in_bump_rocks = false

func _callMethodFinishDead () :
	queue_free()

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):	
		
		self.applySwordEffecs()	
				
		if not self.in_dive:

			if DbBoss.water_spirit.dead == false :
				self.count_to_dive +=1	
				self.count_hits_to_charge += 1
				self.state_machine.travel("hurt")	
				self.current_life = current_life - Players._get_attack(self.defense)			
				floatDamageCount()
				Util.get_an_script("CanvasLayer").handleUpdateHpBarBoss(DbBoss.water_spirit.life, current_life)

			if current_life <= 0:
				if (DbBoss.water_spirit.dead == false):
					self.call_deferred("_cd_magic_circle_death")
					self.state_machine.travel("dead")
					DbBoss.water_spirit.dead =  true
					Util.get_an_script("knight")._increment_exp_player(DbBoss.water_spirit.ptsDead)
					Env._dropGems(self.position, DbBoss.water_spirit.drop_gems)
					var item             = ItemsGbl._get_item_by_code(1025)
					Players._add_item(item, 1)

func applySwordEffecs ():	
	Util.get_an_script("Camera2D").trauma = true
	$SwordHurt01.playing  = true
		
func floatDamageCount () :
	ftd                     = self.floating_text.instance()
	ftd.type                = "damage"
	ftd.flip                = self.motion.x
	ftd.true_positon_sprite = self.true_positon_sprite
	ftd.amount              = int(Players._get_attack(defense))
	add_child(ftd)
		
		
func _cd_magic_circle_death ():
	var circle = load("res://scenes/Enemies/Boss/MagicCircleFinalBoss.tscn")
	circle            = circle.instance()
	circle.position.x = self.position.x
	circle.position.y = -200
	get_parent().add_child(circle)
