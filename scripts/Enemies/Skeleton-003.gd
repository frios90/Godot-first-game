extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
export (int) var can_back_flip   = 1
export (int) var level           = 1
export (float) var scaleX          = -1.8
export (float) var scaleY          = 1.4
export (int) var withMoveAndFlip = 1
export (int) var maxSpeed        = 46
const gravity                    = 1600
const up                         = Vector2(0, -1)
const ptsDead                    = 90
var dead                         = false 
var life                         = 45
var base_attack                  = 45
var base_defense                 = 15
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine

func _ready():		
	state_machine    = $AnimationTree.get("parameters/playback")	
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX	
	scale.y          = scaleY
	$AttackArea/CollisionShape2D.disabled = true

func _process(delta):
	_delta = delta
	if not dead:	
		motion.y += gravity	* delta
		moveOrIdle()
		attacking()		
		flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	Env.non_use = move_and_slide(motion, up)
		
func moveOrIdle():
	if withMoveAndFlip == 1:
		state_machine.travel("walk")
		motion.x = maxSpeed * -1
	else:
		motion.x = 0
		
func flip():
	if $RayFlip.is_colliding() or $RayBackFlip.is_colliding() or not $RayEnd.is_colliding() or ($RayBackFlip.is_colliding() and can_back_flip == 1):
		maxSpeed *= -1
		scale.x  *= -1
		motion.x = maxSpeed		
	
			
func attacking () :
	if $RayAttack.is_colliding() or $RayAttack2.is_colliding():
		state_machine.travel("attack")	
		
func _callMethodStartAttack () :
	is_attacking = true
	$AttackArea/CollisionShape2D.disabled = false
		
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
		
