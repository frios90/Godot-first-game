extends KinematicBody2D

const true_positon_sprite        = false
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0

export (int) var level           = 1
export (int) var scaleX          = 1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed        = 120


const gravity                    = 1600
const up                         = Vector2(0, -1)

const ptsDead                    = 150
var dead                         = false 
var life                         = 50
var base_attack                  = 60
var base_defense                 = 15
var motion                       = Vector2(0, 0)

var is_attacking                 = false
var  is_detecting                = false 
var _delta                       = 0
var useRandSound                 = 0

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)


func _ready():
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = $HPbar.max_value
	scale.x          = scaleX
	$AnimationPlayer.play("attack")
	motion.x = maxSpeed 



func _process(delta):
	if not dead:	
		self.motion.y += self.gravity * delta
		self.flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	Env.non_use = move_and_slide(self.motion, self.up)

func flip():
	if ( $RayFlip.is_colliding() or not $RayEnd.is_colliding() or $RayFront.is_colliding() ):
		self.scale.x  *= -1
		self.motion.x *= -1


		
		
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
				$AnimationPlayer.play("dead")
				Util.get_an_script("knight")._increment_exp_player(ptsDead)
				Env._dropGems(self.position, 20)
				
func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
func _callMethodFinishDead ():
	queue_free()
