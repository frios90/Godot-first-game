extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
const gravity                    = 1600
const ptsDead                    = 120
const up                         = Vector2(0, -1)

var level           = 1

var dead                         = false 
var life                         = DbBoss.flame_spirit.life
var maxSpeed        = 350

var withMoveAndFlip = 0

var base_attack                  = DbBoss.flame_spirit.base_attack
var base_defense                 = DbBoss.flame_spirit.base_defense
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine
var dir_fireball = 1
var power_shoot  = 70
var speed_shoot = 250
var hits_to_charge       = 2
var count_hits_to_charge = 0
var in_fireball = false
var to_flip       = 2
var count_to_flip = 0

var to_leave_fire_ball = 3
var count_to_leave_fire_ball = 0

func _ready():		
	Util.get_an_script("CanvasLayer").get_node("BossBarControl/HPBarBoss").value = DbBoss.flame_spirit.life
	self.state_machine = $AnimationTree.get("parameters/playback")
	self.state_machine.start("idle")
	$AttackArea/CollisionShape2D.disabled = true
	$ChargeArea/CollisionShape2D.disabled = true

func _process(delta):
	self._delta = delta
	if not DbBoss.flame_spirit.dead:	
		
		self.motion.y += gravity * delta
		moveOrIdle()
		attacking()		
		fireball()
		charge()
		flip()
		if is_on_floor():
			self.motion.y = 0
	else:
		$ChargeArea/CollisionShape2D.disabled = true
		$DeadArea/CollisionShape2D.disabled   = true
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
		self.dir_fireball *= -1
		self.speed_shoot  *= -1

func attacking () :
	if $RayAttack.is_colliding():
		motion.x = 0
		state_machine.travel("attack")	
		self.count_to_leave_fire_ball = 0
		
func fireball () :
	if $RayFireball.is_colliding():
		motion.x = 0
		state_machine.travel("fire")
		self.in_fireball = true
	
func charge () :	
	if self.count_hits_to_charge == self.hits_to_charge :		
		$ChargeArea/CollisionShape2D.disabled = false
		$DeadArea/CollisionShape2D.disabled   = true
		state_machine.travel("charge")	
		self.motion.x = self.maxSpeed
		if self.count_to_flip >= self.to_flip :
			randomize()
			self.to_flip  = randi() % 6
			self.count_to_flip = 0
			self.count_hits_to_charge = 0
			$ChargeArea/CollisionShape2D.disabled = true
			$DeadArea/CollisionShape2D.disabled   = false
			

func _call_fireball () :
	var fireball = load("res://scenes/Spells/Fire-ball.tscn")
	fireball = fireball.instance()
	fireball.position.x = self.position.x + (100 * self.dir_fireball)
	fireball.position.y = self.position.y - 20
	fireball.maxSpeed   = self.speed_shoot
	fireball.attack     = self.power_shoot
	fireball.scale.x    = self.dir_fireball
	get_parent().add_child(fireball)
	self.count_to_leave_fire_ball += 1


func _callMethodFinishDead () :
	queue_free()

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):	
			
		self.applySwordEffecs()	
				
		if DbBoss.flame_spirit.dead == false :
			self.count_hits_to_charge += 1
			self.state_machine.travel("hurt")	
			self.current_life = current_life - Players._get_attack(self.defense)			
			floatDamageCount()
			Util.get_an_script("CanvasLayer").handleUpdateHpBarBoss(DbBoss.flame_spirit.life, current_life)

		if current_life <= 0:
			if (DbBoss.flame_spirit.dead == false):
				self.call_deferred("_cd_magic_circle_death")
				self.state_machine.travel("dead")
				DbBoss.flame_spirit.dead =  true
				Util.get_an_script("knight")._increment_exp_player(DbBoss.flame_spirit.ptsDead)
				Env._dropGems(self.position, DbBoss.flame_spirit.drop_gems)
				get_parent()._finish_battle_flame_spirit()
				var item = ItemsGbl._get_item_by_code(1025)
				Players._add_item(item, 1)

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
