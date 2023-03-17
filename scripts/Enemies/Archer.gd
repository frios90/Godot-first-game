extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
export (int) var can_back_flip   = 1
export (int) var level           = 1
export (float) var scaleX        = -1.8
export (float) var scaleY        = 1.4
export (int) var withMoveAndFlip = 1
export (int) var maxSpeed        = 120
const gravity                    = 1600
const up                         = Vector2(0, -1)
const ptsDead                    = 120
var dead                         = false 
var life                         = 200
var base_attack                  = 65
var base_defense                 = 25
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var _delta                       = 0
var useRandSound                 = 0
onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine

var shoot_timer = 100
var shoot       = 0
var power_shoot  = 70
var speed_shoot = -250
var dir_projectile = -1

func _ready():		
	state_machine    = $AnimationTree.get("parameters/playback")	
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX	
	scale.y          = scaleY


func _process(delta):
	_delta = delta
	if not dead:	
		motion.y += gravity	* delta
		idle()
		attacking()		
		flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	Env.non_use = move_and_slide(motion, up)
		
func idle():
	state_machine.travel("idle")
	motion.x = 0
	
func flip():
	if  $RayBackFlip.is_colliding():
		scale.x  *= -1	
		self.dir_projectile *= -1
		self.speed_shoot *= -1

func attacking () :
	if self.shoot > 0: 
		self.shoot += 1
		if self.shoot == self.shoot_timer:
			self.shoot = 0
			
	if $RayAttack.is_colliding() and self.shoot == 0:
		self.shoot = 1
		state_machine.travel("attack")	
		
		
func _callMethodStartAttack () :
	var projectile = load("res://scenes/Spells/Projectile.tscn")
	projectile = projectile.instance()
	projectile.position.x = self.position.x 
	projectile.position.y = self.position.y - 10
	projectile.maxSpeed   = self.speed_shoot
	projectile.attack     = self.power_shoot
	projectile.scale.x    = self.dir_projectile
	print(scale.x)
	get_parent().add_child(projectile)
		
func _callMethodFinishAttack () :
	is_attacking = false
	$AttackArea/CollisionShape2D.disabled = true
	
func _callMethodFinishDead () :
	queue_free()

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):		
		Util.get_an_script("Camera2D").trauma = true
		applySoundSword()			
		if (dead == false):
			state_machine.travel("hurt")	
			current_life = current_life - Players._get_attack(defense)			
			floatDamageCount()
			$HPbar.value = current_life
		if current_life <= 0:
			if (dead == false):
				state_machine.travel("dead")
				dead =  true
				Util.get_an_script("knight")._increment_exp_player(ptsDead)
				Env._dropGems(self.position, 12)

func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
func floatDamageCount () :
	ftd                     = floating_text.instance()
	ftd.type                = "damage"
	ftd.flip                = motion.x
	ftd.true_positon_sprite = true_positon_sprite
	ftd.amount              = int(Players._get_attack(defense))
	add_child(ftd)
		
