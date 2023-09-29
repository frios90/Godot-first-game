extends KinematicBody2D

const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0

export (int) var level           = 1
export (int) var scaleX          = 1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed        = 50


const gravity                    = 1600
const up                         = Vector2(0, -1)

const ptsDead                    = 60
var dead                         = false 
var life                         = 45
var base_attack                  = 40
var base_defense                 = 15
var motion                       = Vector2(0, 0)

var is_attacking                 = false
var  is_detecting                = false 
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var state_machine
func _ready():
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX
	state_machine    = $AnimationTree.get("parameters/playback")

	state_machine.start("walk")
	motion.x = maxSpeed * -1
	$AttackArea/CollisionShape2D.disabled = true


func _process(delta):
	if not dead:	
		self.motion.y += self.gravity * delta
		self.flip()
		self.detect()
		self.goAttack()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	Env.non_use = move_and_slide(self.motion, self.up)

func flip():
	if ( $RayFlip.is_colliding() or not $RayEnd.is_colliding() or $RayBack.is_colliding() ) and not $RayDetect.is_colliding():
		self.scale.x  *= -1
		self.motion.x *= -1

func detect ():
	if $RayDetect.is_colliding() and not is_detecting :		
		is_detecting = true
		state_machine.travel("detect")
		motion.x = 0

func goAttack ():
	if $RayAttack.is_colliding() :	
		is_attacking = true	
		$AttackArea/CollisionShape2D.disabled = false
		state_machine.travel("attack")
		motion.y = -10
		
		
func _call_method_finish_detect () :
	motion.x = maxSpeed * -5
	
func _call_method_finish_dead () :
	self.queue_free()

func _call_method_finish_attack () :
	is_attacking = false
	$AttackArea/CollisionShape2D.disabled = true
	
func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):
		Util.get_an_script("Camera2D").trauma = true
		applySoundSword()
		if self.dead == false:
			self.current_life = self.current_life - Players._get_attack(defense)
			floatDamageCount()
			$HPbar.value = current_life
		if current_life <= 0:
			if (dead == false):
				dead =  true
				state_machine.travel("dead")
				Env._dropGems(self.position, ptsDead)
				randomize()
				var drop_item_probability = randi() % 3
				if drop_item_probability == 1:
					var item = ItemsGbl._get_item_by_code(1013)
					Players._add_item(item, 1)
				
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
