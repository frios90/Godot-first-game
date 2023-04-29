extends KinematicBody2D
const true_positon_sprite        = true
var floating_text                = preload("res://scenes/FloatingText.tscn")
var ftd                          = 0

export (int) var level           = 1
export (int) var scaleX          = -1
export (int) var withMoveAndFlip = 0
export (int) var maxSpeed        = 60
const gravity                    = 1600
const up                         = Vector2(0, -1)
const ptsDead                    = 50
var dead                         = false
var life                         = 30
var base_attack                  = 30
var base_defense                 = 7

onready var attack               = base_attack if level == 1 else base_attack * (level * 0.77)
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)

var motion                       = Vector2(0, 0)
var raise                        = false

var is_attacking                 = true
var useRandSound                 = 0
var old_motion_x                 = 0

var resistance                   = {
	"flame" : 50,
	"sand" : 50,
	"wind" : 50,
	"liquid" : 50
}

func _ready():	
	$HPbar.visible   = false
	maxSpeed        *= -1
	
func _process(delta):
	if not dead:	
		motion.y += gravity	* delta		
		initRaise()
		flip()
		if is_on_floor():
			motion.y = 0
	else:		
		self._desactivate_event(true)
		dead         = false
		old_motion_x = motion.x
		motion.x     = 0
		
		yield(get_tree().create_timer(4), "timeout")	
		motion.x = old_motion_x					
		current_life = life
		$AnimationPlayer.play("raise")
		
	Env.non_use = move_and_slide(motion, up)
	
	

func _desactivate_event (desactivate) :	
	if desactivate:
		$HPbar.visible                        = false
		$DeadArea/CollisionShape2D.disabled   = true
		$AttackArea/CollisionShape2D.disabled = true
		$RayBackFlip.enabled                  = false
	else:
		$HPbar.visible                        = true
		$DeadArea/CollisionShape2D.disabled   = false
		$AttackArea/CollisionShape2D.disabled = false
		$RayBackFlip.enabled                  = true
		
func initRaise () :
	if $RayRaise.is_colliding() and not raise:
		$AnimationPlayer.play("raise")
		
func flip():
	if ($RayFlip.is_colliding() or not $RayEnd.is_colliding() or $RayBackFlip.is_colliding()) and raise:
		maxSpeed *= -1
		scale.x  *= -1
		motion.x = maxSpeed		
		
func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword"):
		applySoundSword()
		Util.get_an_script("Camera2D").trauma = true
		if not dead:
			current_life = current_life - Players._get_attack(self.defense, self.resistance)
			$HPbar.value = current_life
			floatDamageCount()	
		if current_life <= 0:
			if (dead == false):
				$AnimationPlayer.play("dead")
				dead =  true	
				Util.get_an_script("knight")._increment_exp_player(ptsDead)	
				Env._dropGems(self.position, 20)
				randomize()
				var drop_item_probability = randi() % 4
				if drop_item_probability == 1:
					var item = ItemsGbl._get_item_by_code(1001)
					Players._add_item(item, 1)
				

func applySoundSword ():
	if useRandSound == 0:
		$SwordHurt01.playing = true
	else:
		$SwordHurt02.playing = true
		
func _callMethodFinishRaise ():
	self._desactivate_event(false)		
	$AnimationPlayer.play("walk")
	motion.x         = maxSpeed
	raise            = true	
	$HPbar.visible   = true
	$HPbar.max_value = life if level == 1 else life * (level * 0.77)
	$HPbar.value     = life if level == 1 else life * (level * 0.77)	

func _callMethodFinishDead ():	
	$AnimationPlayer.play("sleep")

func floatDamageCount () :
	ftd                     = floating_text.instance()
	ftd.type                = "damage"
	ftd.flip                = motion.x
	ftd.true_positon_sprite = true_positon_sprite
	ftd.amount              = int(Players._get_attack(defense))
	add_child(ftd)
		

func _on_AttackArea_area_entered(_area):
	
	pass # Replace with function body.
