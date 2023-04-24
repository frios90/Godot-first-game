extends KinematicBody2D
const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0
const gravity                    = 1600
const ptsDead                    = 120
const up                         = Vector2(0, -1)

var level           = 1

var dead                         = false 
var life                         = DbBoss.wind_spirit.life
var maxSpeed        = 350

var withMoveAndFlip = 0

var base_attack                  = DbBoss.wind_spirit.base_attack
var base_defense                 = DbBoss.wind_spirit.base_defense
var motion                       = Vector2(0, 0)
var is_attacking                 = false
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine


func _ready():		
	self.state_machine = $AnimationTree.get("parameters/playback")
	self.state_machine.start("idle")

func _process(delta):
	self._delta = delta
	if not DbBoss.wind_spirit.dead:
		
		self.motion.y += gravity * delta
		moveOrIdle()
		if is_on_floor():
			self.motion.y = 0
	else:
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
	
func _dead():
	if (DbBoss.wind_spirit.dead == false):
		$CollisionShape2D.disabled = true
		self.position.y = self.position.y +30
		self.call_deferred("_cd_magic_circle_death")
		DbBoss.wind_spirit.dead = true
		self.state_machine.travel("dead")

func _cd_magic_circle_death ():
	var circle = load("res://scenes/Enemies/Boss/MagicCircleFinalBoss.tscn")
	circle            = circle.instance()
	circle.position.x = self.position.x
	circle.position.y = -200
	get_parent().add_child(circle)
