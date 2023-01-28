extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
export (int) var level           = 1
export (int) var scaleX          = 1.3
export (int) var scaleY          = 1.3
export (int) var maxSpeed        = -30
export (int) var ptsDead         = 100
export (int) var dropGem         = 200
export (int) var life            = 120
export (int) var base_attack     = 50
export (int) var base_defense    = 35

const gravity                    = 1600
const up                         = Vector2(0, -1)
var dead                         = false 
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var is_rise                      = false
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine

func _ready():		
	state_machine    = $AnimationTree.get("parameters/playback")	
	state_machine.start("init")	
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX	
	scale.y          = scaleY	
	$AttackArea/CollisionShape2D.disabled = true

func _process(delta):
	_delta = delta
	if not self.dead:	
		self.motion.y += gravity	* delta
		self.rise()
		self.attacking()		
		self.flip()		
		if is_on_floor():
			self.motion.y = 0
	else:
		self.motion = Vector2(0, 0)	
	Env.non_use = move_and_slide(motion, up)
		
func flip():
	if ($Rays/Flip.is_colliding() and not $Rays/BackFlip.is_colliding()) or ( not $Rays/Flip.is_colliding() and $Rays/BackFlip.is_colliding()):
		self.state_machine.travel("walk")	
		self.maxSpeed *= -1
		self.scale.x  *= -1
		self.motion.x = self.maxSpeed		
	
func rise () :
	if ($Rays/Rise.is_colliding() or $Rays/RiseBack.is_colliding()) and not self.is_rise:
		self.state_machine.travel("rise")
		self.is_rise = true
					
func attacking () :
	if $Rays/Attack.is_colliding() and not self.is_attacking:
		$Rays/Attack.enabled = false
		self.state_machine.travel("attack")		
		self.motion.x = 0
		self.is_attacking = true	
		get_tree().create_timer(2).connect("timeout", self, "_finish_attack")

func _cm_enabled_Attack ():
	$AttackArea/CollisionShape2D.disabled = false
	
func _cm_disabled_Attack ():
	$AttackArea/CollisionShape2D.disabled = true		
		
func _finish_attack () :
	self.is_attacking = false	
	$Rays/Attack.enabled = true

func _callMethodStartAttack () :
	is_attacking = true
	$AttackArea/CollisionShape2D.disabled = false
		
func _callMethodFinishAttack () :
	is_attacking = false
	$AttackArea/CollisionShape2D.disabled = true
	
func _callMethodFinishDead () :
	queue_free()

func _cd_finish_dead () :
	self.queue_free()

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
				Env._dropGems(self.position, dropGem)

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
		
