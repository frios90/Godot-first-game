extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
var from_necromancer             = false
export (int) var level           = 1
export (int) var scaleX          = -1
export (int) var withMoveAndFlip = 0

const gravity            = 50
const up                 = Vector2(0, -1)
const ptsDead            = 350

var dead                 = false

var life                 = 80
onready var current_life = life if level == 1 else life * (level * 0.77)

var base_attack     = 60
var base_defense    = 25
onready var attack  = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense = base_defense if level == 1 else base_defense * (level * 0.55)

var motion        = Vector2(0, 0)
var is_attacking  = false
var _delta        = 0
var target        = {"x":0,"y":0}

var useRandSound = 0
var timer_attack = 0
var _drop_gems   = 60
var state_machine

func _ready():	
	state_machine    = $AnimationTree.get("parameters/playback")	
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX
	motion.x         = 0
	state_machine.start("idle")

func _process(delta):
	_delta = delta
	if not dead:
		moveOrIdle()
		attacking()
		flip()
		if is_on_floor():
			motion.y = 0
		Env.non_use = move_and_slide(motion, up)
	else:
		motion              = Vector2(0, 0)	
		motion.y            = gravity
		Env.non_use         = move_and_slide(motion, up)
		


func moveOrIdle():
	if withMoveAndFlip == 1:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
		
func flip():
	if  $Rays/Back.is_colliding()  or  $Rays/D_back.is_colliding():
		motion.x *= -1
		scale.x  *= -1
			
func attacking () :

	if not is_attacking:		
		if $Rays/D_back.is_colliding():			
			self.state_machine.travel("attack")
			self.target.x = $Rays/D_back.get_collider().position[0]
			self.target.y = $Rays/D_back.get_collider().position[1]
			self.is_attacking = true
		elif $Rays/Down.is_colliding():

			self.state_machine.travel("attack")
			self.target.x = $Rays/Down.get_collider().position[0]
			self.target.y = $Rays/Down.get_collider().position[1]
			self.is_attacking = true
		elif $Rays/D_front.is_colliding():

			self.state_machine.travel("attack")
			self.target.x = $Rays/D_front.get_collider().position[0]
			self.target.y = $Rays/D_front.get_collider().position[1]
			self.is_attacking = true
		elif $Rays/Front.is_colliding():

			self.state_machine.travel("attack")
			self.target.x = $Rays/Front.get_collider().position[0]
			self.target.y = $Rays/Front.get_collider().position[1]
			self.is_attacking = true
		elif $Rays/Back.is_colliding():

			self.state_machine.travel("attack")
			self.target.x = $Rays/Back.get_collider().position[0]
			self.target.y = $Rays/Back.get_collider().position[1]
			self.is_attacking = true
			
	else :
		get_tree().create_timer(1).connect("timeout", self, "_cm_finish_attack")
	
			
func _cm_cast_spell ():	
	var spell        = load("res://scenes/Spells/Spell-001-spark.tscn")
	spell            = spell.instance()
	spell.position.x = self.target.x
	spell.position.y = self.target.y
	spell.attack     = attack	
	if not from_necromancer:		 
		get_parent().add_child(spell)
	else :
		get_parent().get_parent().add_child(spell)
	
func _cm_finish_attack ():
	self.is_attacking = false
	
func _cm_finish_dead () :
	queue_free()

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):		
		Util.get_an_script("Camera2D").trauma = true
		applySoundSword()			
		if (dead == false):
			self.current_life = self.current_life - Players._get_attack(defense)
			self.state_machine.travel("hurt")	
			floatDamageCount()
			$HPbar.value = self.current_life
		if self.current_life <= 0:
			if (self.dead == false):
				self.dead =  true			
				self.state_machine.travel("dead")
				Util.get_an_script("knight")._increment_exp_player(ptsDead)
				Env._dropGems(self.position, _drop_gems)

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
	ftd.amount              = int( Players._get_attack(defense))
	add_child(ftd)
