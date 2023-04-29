extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
const gravity                    = 1600
const ptsDead                    = 120
const up                         = Vector2(0, -1)

var level           = 1

var dead                         = false 
var life                         = DbBoss.sand_spirit.life
var maxSpeed        = 350

var withMoveAndFlip = 0

var base_attack                  = DbBoss.sand_spirit.base_attack
var base_defense                 = DbBoss.sand_spirit.base_defense
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine
var dir_rocks_attack = 1
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

var to_wall_rocks       = 1
var count_to_wall_rocks = 0
var in_wall_rocks       = false

func _ready():
	Util.get_an_script("CanvasLayer").get_node("BossBarControl/HPBarBoss").value = DbBoss.sand_spirit.life
	self.state_machine = $AnimationTree.get("parameters/playback")
	self.state_machine.start("idle")
	$AttackArea/CollisionShape2D.disabled = true
	$ChargeArea/CollisionShape2D.disabled = true

func _process(delta):
	self._delta = delta
	if not DbBoss.sand_spirit.dead:	
		
		self.motion.y += gravity * delta
		moveOrIdle()
		attacking()
		bumpRocks()
		fallRocks()
		wallRocks()
		charge()
		flip()
		if is_on_floor():
			self.motion.y = 0
	else:
		$ChargeArea/CollisionShape2D.disabled = true
		$DeadArea/CollisionShape2D.disabled   = true
		$AttackArea/CollisionShape2D.disabled = true
		self.state_machine.travel("dead")
		self.motion = Vector2(0, 0)	
		
	Env.non_use = move_and_slide(motion, up)
		
func moveOrIdle():
	if withMoveAndFlip == 1:
		self.state_machine.travel("walk")
		self.motion.x = maxSpeed * -1
	else:
		self.state_machine.travel("idle")
		self.motion.x = 0
		
func flip():
	if $RayFlip.is_colliding():
		self.count_to_flip +=1
		self.maxSpeed *= -1
		self.scale.x  *= -1
		self.motion.x = self.maxSpeed
		self.dir_rocks_attack *= -1
		self.speed_shoot  *= -1
		
		var fase_2 = self.life * 0.7
		if self.current_life <= fase_2:
			self.count_to_wall_rocks += 1
			
			var fase_3 = self.life * 0.4
			if self.current_life <= fase_3:
				self.count_to_fall_rocks += 1

func attacking () :
	if $RayAttack.is_colliding():
		motion.x = 0
		state_machine.travel("attack")	
		self.count_to_leave_bump_rocks = 0

func _cm_init_attack () :
	$AttackArea/CollisionShape2D.disabled   = false

func _cm_end_attack () :
	$AttackArea/CollisionShape2D.disabled   = true
		
func bumpRocks () :
	if $RayBumpRocks.is_colliding():
		motion.x = 0
		state_machine.travel("fire")
#		self.in_bump_rocks = true

func fallRocks () :
	if self.to_fall_rocks == self.count_to_fall_rocks:		
		state_machine.travel("FallRocks")
		self.in_fall_rocks = true
		
func wallRocks () :
	if self.to_wall_rocks == self.count_to_wall_rocks:		
		state_machine.travel("WallRocks")
		self.in_wall_rocks = true		
	
func charge () :	
	if self.count_hits_to_charge == self.hits_to_charge and not self.in_bump_rocks and not self.in_fall_rocks and not self.in_wall_rocks:
		$ChargeArea/CollisionShape2D.disabled = false
		$DeadArea/CollisionShape2D.disabled   = true
		state_machine.travel("charge")	
		self.motion.x = self.maxSpeed
		if self.count_to_flip >= self.to_flip :
			self.count_to_flip = 0
			self.count_hits_to_charge = 0
			$ChargeArea/CollisionShape2D.disabled = true
			$DeadArea/CollisionShape2D.disabled   = false
			
			if self.count_to_wall_rocks == self.to_wall_rocks:
				self.wallRocks()
			

func _call_bumrock () :
	var bumprock = load("res://scenes/Spells/BumpRock.tscn")
	bumprock = bumprock.instance()
	bumprock.position.x = self.position.x + (50 * self.dir_rocks_attack)
	bumprock.position.y = self.position.y + 46
	bumprock.scale.x    = self.dir_rocks_attack
	bumprock.speed      = bumprock.speed * self.dir_rocks_attack 
	get_parent().add_child(bumprock)
	self.count_to_leave_bump_rocks += 1
	self.in_bump_rocks = false


func _call_fall_rocks () :	
	for i in 5:
		var fallrocks = load("res://scenes/Spells/FallRock.tscn")
		fallrocks = fallrocks.instance()
		fallrocks.position.x = self.position.x + (50 * i * 3 * self.dir_rocks_attack)
		fallrocks.position.y = self.position.y  - 250

		fallrocks.scale.y    = 2.5
		fallrocks.scale.x    = self.dir_rocks_attack * 2.5
		fallrocks.speed      = fallrocks.speed * self.dir_rocks_attack 
		get_parent().add_child(fallrocks)
		
	self.count_to_fall_rocks = 0
	self.in_fall_rocks = false

func _call_wall_rocks () :	
	var initialX = self.position.x + 100 * self.dir_rocks_attack
	for i in 5:
		var wallrocks = load("res://scenes/Spells/WallRock.tscn")
		wallrocks = wallrocks.instance()
		wallrocks.position.x = initialX + (50 * i * 3 * self.dir_rocks_attack)
		wallrocks.position.y = self.position.y
		wallrocks.scale.x    = self.dir_rocks_attack
		get_parent().add_child(wallrocks)
		
	self.count_to_wall_rocks = 0
	self.in_wall_rocks = false

func _callMethodFinishDead () :
	queue_free()

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):	
			
		self.applySwordEffecs()	
				
		if DbBoss.sand_spirit.dead == false :
			self.count_hits_to_charge += 1
			self.state_machine.travel("hurt")	
			self.current_life = current_life - Players._get_attack(self.defense)			
			floatDamageCount()
			Util.get_an_script("CanvasLayer").handleUpdateHpBarBoss(DbBoss.sand_spirit.life, current_life)

		if current_life <= 0:
			if (DbBoss.sand_spirit.dead == false):
				self.call_deferred("_cd_magic_circle_death")
				self.state_machine.travel("dead")
				DbBoss.sand_spirit.dead =  true
				Util.get_an_script("knight")._increment_exp_player(DbBoss.sand_spirit.ptsDead)
				Env._dropGems(self.position, DbBoss.sand_spirit.drop_gems)
				get_parent()._finish_battle_sand_spirit()

func applySwordEffecs ():	
	print("aqui esta esto")
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
