extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0

export (int) var level           = 1
export (int) var scaleX          = -1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed        = -26

const gravity            = 50
const up                 = Vector2(0, -1)
const ptsDead            = 150

var dead                 = false

var life                 = 800

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

var count_invoque_003 = 3
var init_actions = false

var timer_inveque_003     = 0
var limit_wait_invoque003 = 200
var has_shield = false

func _ready():
	if DbBoss.necromancer_002.dead:
		self.queue_free()
	else:	
		Util.get_an_script("CanvasLayer").get_node("BossBarControl/HPBarBoss").value = self.life
		self.scale.x       = scaleX		
		self.state_machine = $AnimationTree.get("parameters/playback")	
		self.state_machine.start("idle")
	
func _process(delta):
	_delta = delta
	if not dead:
		self.castSpellA()
		self.flip()
		self.createShield()
	else:
		motion      = Vector2(0, 0)	
		motion.y    = gravity
		Env.non_use = move_and_slide(motion, up)
		var pretime_to_dead = get_tree().create_timer(0.33)
		pretime_to_dead.connect("timeout", self, "_preTimeToDead")	

func castSpellA ():
	if not get_parent().has_node("Invoque003"):
		self.timer_inveque_003 += 1
		if (self.timer_inveque_003 == self.limit_wait_invoque003):		
			self.timer_inveque_003 = 0
			self.state_machine.travel("castSpellA")
	
func spell_a_invoque003 ():
	var inv003 = load("res://scenes/Enemies/Boss/Necromancer/Invoque003.tscn")
	inv003 = inv003.instance()
	get_parent().add_child(inv003)

func createShield ():
	if not get_parent().has_node("ShieldSkull") and not self.has_shield :
		self.has_shield = true
		var timer_spell_c = get_tree().create_timer(2)
		timer_spell_c.connect("timeout", self, "spell_c")	
	
func spell_c ():
	state_machine.travel("castSpellC")

func _spell_c_kill_invoque003 ():
	if get_parent().has_node("Invoque003"):
		get_parent().get_node("Invoque003").queue_free()
	
func _spell_c_new_shield() :	
	var shield = load("res://scenes/Enemies/Boss/Necromancer/ShieldSkull.tscn")
	shield = shield.instance()
	shield.position.x = self.position.x - 70
	shield.position.y = self.position.y
	get_parent().add_child(shield)

func _preTimeToDead () :
	queue_free()
		
func flip():
	if  $Rays/BackFlip.is_colliding():
		print("collition")
		motion.x *= -1
		scale.x  *= -1
	
func castSpellC ():
	if  $Rays/SpellSkull.is_colliding():	
		print("esto esta collisionanda")	
		var skull = load("res://scenes/Enemies/Boss/Necromancer/SkullSpellAttack.tscn")
		var collider = $Rays/SpellSkull.get_collider()
		skull = skull.instance()
		skull.position.x = collider.position[0]
		skull.position.y = collider.position[1]
		skull.attack = attack
		print(skull)
		yield(get_tree().create_timer(0.3), "timeout")	
		get_parent().add_child(skull)

func _timeout_finish_attach () :
	is_attacking = false

func _callMethodCastSpell ():
	pass
	
func _callMethodFinishDead () :
	queue_free()



func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true

