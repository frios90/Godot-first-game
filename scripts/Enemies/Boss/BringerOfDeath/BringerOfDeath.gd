extends KinematicBody2D

const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
export (int) var level           = 1
export (int) var scaleX          = 2
export (int) var withMoveAndFlip = 0
var maxSpeed                     = 120
const gravity                    = 1600
const up                         = Vector2(0, -1)
const ptsDead                    = 4000
var dead                         = false 
var life                         = 1200
var base_attack                  = 80
var base_defense                 = 32

var is_attacking                 = false
var is_teletransport             = false
var is_hurting                   = false
var is_cast_spell                = false
var _delta                       = 0
var useRandSound                 = 0
var count_damage_hits                  = 0


onready var motion               = Vector2(0, 0)
onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)
var state_machine

func _ready():		
	Util.get_an_script("CanvasLayer").get_node("HPBarBoss").visible=true
	Util.get_an_script("CanvasLayer").get_node("HPBarBoss").value=life
	scale.x   = scaleX
	maxSpeed *= -1
	motion.x = maxSpeed
	state_machine = $AnimationTree.get("parameters/playback")	
	state_machine.start("idle")
	

	
func _process(delta):
	_delta = delta
	if not dead:	
		motion.y += gravity	* delta
		if not is_teletransport:
			state_machine.travel("walk")
		attacking()		
		flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	move_and_slide(motion, up)

func flip():
	if $RayFrontFlip.is_colliding() or $RayBackFlip.is_colliding() and not is_attacking and not is_hurting:
		motion.x *= -1
		scale.x  *= -1

func attacking () :
	if $RaySwordAttack.is_colliding():		
		state_machine.travel("attack")
		if current_life < life*0.45:
			if not is_cast_spell:
				state_machine.travel("spell")
		

##Metodos de la animación atacar
func _CM_init_attack_animation ():
	is_attacking = true
	maxSpeed     = motion.x
	motion.x     = 0
	
func _callMethodStartAttack () :	
	$AttackArea/CollisionShape2D.disabled = false
		
func _callMethodFinishAttack () :	
	$AttackArea/CollisionShape2D.disabled = true
	
func _CM_finish_attack_animation ():
	motion.x = maxSpeed
	is_attacking = false
	
func _callMethodFinishDead () :
	queue_free()

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):
		Util.get_an_script("Camera2D").trauma = true
		applySoundSword()
		if (dead == false):
			_ADD_CHILD_DAMAGE()
			state_machine.travel("hurt")			
			current_life = current_life - Players._get_attack(defense)
			Util.get_an_script("CanvasLayer").handleUpdateHpBarBoss(life, current_life)
			_damage_teletransport()			
		if current_life <= 0:
			_DEAD()

func _damage_teletransport ():
	count_damage_hits += 1
	if count_damage_hits % 6 == 0:		
		is_teletransport = true
		yield(get_tree().create_timer(0.5), "timeout")
		state_machine.travel("tele")		
		count_damage_hits = 0
		var timer_come_back = get_tree().create_timer(4)
		timer_come_back.connect("timeout", self, "_return_teletransport")	
		$DeadArea/CollisionShape2D.disabled = true
		$RaySwordAttack.enabled             = false

func _return_teletransport ():
	state_machine.travel("comebacktele")
	is_teletransport = false
	$DeadArea/CollisionShape2D.disabled = false
	$RaySwordAttack.enabled             = true


func _CM_init_spell_event () :
	maxSpeed = motion.x
	motion.x = 0
	
func _CM_finish_spell_event () :
	var collider     = get_parent().get_node("knight")
	var spell        = load("res://scenes/Enemies/Boss/BringerOfDeath/BringerHandAttack.tscn")
	spell            = spell.instance()
	spell.position.x = collider.position[0]
	spell.position.y = -1230
	get_parent().add_child(spell)
	motion.x = maxSpeed
	
func _CM_init_hurt () :
#	maxSpeed = motion.x
#	motion.x = 0
	is_hurting = true
	$DeadArea/CollisionShape2D.disabled = true
	
func _CM_finish_hurt () :
#	motion.x   = maxSpeed
	is_hurting = false
	$DeadArea/CollisionShape2D.disabled = false
	
func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
func _ADD_CHILD_DAMAGE () :
	ftd = floating_text.instance()
	ftd.type = "damage"
	ftd.flip = -motion.x
	ftd.true_positon_sprite = true_positon_sprite
	ftd.amount = Players._get_attack(defense)
	add_child(ftd)

func _DEAD ():
	if (dead == false):
		dead =  true			
		state_machine.travel("dead")
		Util.get_an_script("knight")._increment_exp_player(ptsDead)
		Env._dropGems(self.position, 1000)
		
func _on_AttackArea_area_entered(area):
	pass # Replace with function body.
