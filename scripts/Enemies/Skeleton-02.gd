extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
export (int) var level           = 1
export (int) var scaleX          = -1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed        = 26
const gravity                    = 1600
const up                         = Vector2(0, -1)
const ptsDead                    = 100
var dead                         = false 
var life                         = 100
var base_attack                  = 35
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
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x = scaleX
	state_machine = $AnimationTree.get("parameters/playback")	
	if withMoveAndFlip == 1:
		state_machine.start("walk")		
		motion.x = maxSpeed * scaleX
	else:
		state_machine.start("idle")
		motion.x = 0
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
	else:
		state_machine.travel("idle")
		
func flip():
	if withMoveAndFlip == 1 :
		if $RayFlip.is_colliding() or $RayBackFlip.is_colliding()  or $RayEnd.is_colliding() == false:
			motion.x *= -1
			scale.x  *= -1
	elif $RayBackFlip.is_colliding():
		motion.x *= -1
		scale.x  *= -1
			
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
			current_life = current_life - Players._get_attack(defense)
			state_machine.travel("hurt")	
			ftd = floating_text.instance()
			ftd.type = "damage"
			ftd.flip = motion.x
			ftd.true_positon_sprite = true_positon_sprite
			ftd.amount = Players._get_attack(defense)
			add_child(ftd)
			$HPbar.value = current_life
		if current_life <= 0:
			if (dead == false):
				dead =  true			
				state_machine.travel("dead")
				Util.get_an_script("knight")._increment_exp_player(ptsDead)
				Env._dropGems(self.position, 12)

func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
