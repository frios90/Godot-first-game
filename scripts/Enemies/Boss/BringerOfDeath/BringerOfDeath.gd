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
const ptsDead                    = 3000
var dead                         = false 

var life                         = 15000
var base_attack                  = 160
var base_defense                 = 50

var is_attacking                 = false
var is_teletransport             = false
var is_hurting                   = false
var is_cast_spell                = false
var is_spelling                  = false

var useRandSound                 = 0
var count_damage_hits            = 0
var to_second_raund              = 0.49
var _drop_gems                   = 5000

onready var motion               = Vector2(0, 0)
onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)
var state_machine

func _ready():
	if DbBoss.bringer_of_deadth_001.dead:
		self.queue_free()
	else:	
		Util.get_an_script("CanvasLayer").get_node("BossBarControl/HPBarBoss").value = life
		scale.x       = scaleX
		maxSpeed     *= -1
		motion.x      = maxSpeed
		state_machine = $AnimationTree.get("parameters/playback")	
		state_machine.start("idle")

func _process(delta):
	if not dead and withMoveAndFlip == 1:	
		motion.y += gravity	* delta
		if not is_teletransport:
			state_machine.travel("walk")
		attacking()		
		flip()

		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	Env.non_use = move_and_slide(motion, up)

func flip():
	if $RayFrontFlip.is_colliding() or $RayBackFlip.is_colliding() and not is_attacking and not is_hurting and not is_spelling:
		motion.x *= -1
		scale.x  *= -1

func attacking () :
	if $RaySwordAttack.is_colliding():		
		state_machine.travel("attack")
		if current_life < life*to_second_raund:
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


func _damage_teletransport ():
	count_damage_hits += 1
	if count_damage_hits % 6 == 0 and self:		
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
	is_spelling = true
	maxSpeed = motion.x
	motion.x = 0
	
func _CM_finish_spell_event () :
	var collider     = get_parent().get_node("knight")
	var spell        = load("res://scenes/Enemies/Boss/BringerOfDeath/BringerHandAttack.tscn")
	spell            = spell.instance()
	spell.position.x = collider.position[0]
	spell.position.y = -1230
	get_parent().add_child(spell)
	is_spelling      = false
	motion.x         = maxSpeed
	
func _CM_init_hurt () :
	is_hurting = true
	$DeadArea/CollisionShape2D.disabled = true
	
func _CM_finish_hurt () :
	is_hurting = false
	$DeadArea/CollisionShape2D.disabled = false
	
func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
func _ADD_CHILD_DAMAGE () :
	ftd                     = floating_text.instance()
	ftd.type                = "damage"
	ftd.flip                = -motion.x
	ftd.true_positon_sprite = true_positon_sprite
	ftd.amount              = int(Players._get_attack(defense))
	add_child(ftd)

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):
		Util.get_an_script("Camera2D").trauma = true
		applySoundSword()
		if (dead == false):
			_ADD_CHILD_DAMAGE()
			state_machine.travel("hurt")			
			current_life = current_life - Players._get_attack(defense)
			current_life = current_life - Players._get_attack(defense)
			Util.get_an_script("CanvasLayer").handleUpdateHpBarBoss(life, current_life)
			_damage_teletransport()						
		if current_life <= 0:
			_DEAD()
	
func _cd_magic_circle_death ():
	var circle = load("res://scenes/Enemies/Boss/MagicCircleFinalBoss.tscn")
	circle            = circle.instance()
	circle.position.x = self.position.x
	circle.position.y = -1216
	get_parent().add_child(circle)
	
func _DEAD ():
	if (dead == false):
		DbBoss.bringer_of_deadth_001.dead = true
		dead =  true			
		self.call_deferred("_cd_magic_circle_death")
		state_machine.travel("dead")
		Util.get_an_script("knight")._increment_exp_player(ptsDead)		
		Env._dropGems(self.position, _drop_gems)
		if get_parent().has_node("BringerHandAttack"):
			get_parent().get_node("BringerHandAttack").queue_free()
		get_parent()._finish_battle()

func _callMethodFinishDead () :
	self.queue_free()
