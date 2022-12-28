extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0

export (int) var level           = 1
export (int) var scaleX          = -1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed = 26

const gravity            = 50
const up                 = Vector2(0, -1)
const ptsDead            = 150

var dead                 = false

var life                 = 35
onready var current_life = life if level == 1 else life * (level * 0.77)

var base_attack     = 45
var base_defense    = 15
onready var attack  = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense = base_defense if level == 1 else base_defense * (level * 0.55)

var motion        = Vector2(0, 0)
var is_attacking  = false
var _delta        = 0

var useRandSound  = 0
var timer_attack = 0
var state_machine

func _ready():
	
	state_machine = $AnimationTree.get("parameters/playback")
	
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX
	
	if withMoveAndFlip == 1:
		state_machine.start("walk")		
		motion.x = maxSpeed * scaleX
	else:
		state_machine.start("idle")
		motion.x = 0

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
		motion      = Vector2(0, 0)	
		motion.y    = gravity
		Env.non_use = move_and_slide(motion, up)
		yield(get_tree().create_timer(0.09), "timeout")
		queue_free()

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
			castSpell($Rays/D_back.get_collider())
		elif $Rays/Down.is_colliding():		
			castSpell($Rays/Down.get_collider())
		elif $Rays/D_front.is_colliding():
			castSpell($Rays/D_front.get_collider())
		elif $Rays/Front.is_colliding():
			castSpell($Rays/Front.get_collider())
		elif $Rays/Back.is_colliding():
			castSpell($Rays/Back.get_collider())
			
func castSpell (collider):
	is_attacking = true
	timer_attack = get_tree().create_timer(1)
	timer_attack.connect("timeout", self, "_timeout_finish_attach")	
	var spell = load("res://scenes/Spells/Spell-001-spark.tscn")
	spell = spell.instance()
	spell.position.x = collider.position[0]
	spell.position.y = collider.position[1]
	spell.attack = attack		
	yield(get_tree().create_timer(0.5), "timeout")	
	get_parent().add_child(spell)
	state_machine.travel("attack")	
		
func _timeout_finish_attach () :
	is_attacking = false

func _callMethodCastSpell ():
	pass
	
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

