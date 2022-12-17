extends KinematicBody2D
const true_positon_sprite = true
var floating_text = preload("res://scenes/FloatingText.tscn")
var ftd = 0

export (int) var level  = 1
export (int) var scaleX = -1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed = 30

const gravity    = 1600
const up         = Vector2(0, -1)
const ptsDead    = 100

var dead         = false

var life         = 100
var base_attack  = 30
var base_defense = 7

onready var attack       = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense      = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life = life if level == 1 else life * (level * 0.77)

var motion = Vector2(0, 0)
var raise  = false

var is_attacking  = true
var useRandSound = 0

func _ready():
	
	$HPbar.visible = false
		
	
func _process(delta):
	if not dead:	
		motion.y += gravity	* delta
		initRaice()
		flip()
		if is_on_floor():
			motion.y = 0
	else:
		motion = Vector2(0, 0)	
	move_and_slide(motion, up)
		
func initRaice () :
	if $RayRaise.is_colliding() and raise == false :
		$AnimationPlayer.play("raise")
		raise = true
		
func flip():	
	if $RayFlip.is_colliding() or $RayEnd.is_colliding() == false:
		motion.x *= -1
		scale.x  *= -1
#			

func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):
		applySoundSword()
		Util.get_an_script("Camera2D").trauma = true
		if (dead == false):			
			current_life = current_life - Players._get_attack(defense)
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
				Util.get_an_script("CanvasLayer").handleIncrementExp(ptsDead)
					

func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing  = true
	else:
		$SwordHurt02.playing  = true
		
func _callMethodFinishRaise ():
	$AnimationPlayer.play("walk")
	$HPbar.visible   = true
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = life if level == 1 else life * (level * 0.77)	
	motion.x = maxSpeed * scaleX
		
func _callMethodFinishDead ():
	queue_free()
