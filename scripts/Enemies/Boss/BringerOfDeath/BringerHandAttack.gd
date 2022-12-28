extends KinematicBody2D

const up         = Vector2(0, -1)
var attack       = 80
var speed        = 250
var motion       = Vector2(0, 0)
var is_attacking = false

func _ready():

	$AnimationPlayer.play("idle")
	motion.x = speed
	get_parent().get_node("BringerOfDeath").is_cast_spell = true

func _process(delta):
			
	flip()
	attack()
	move_and_slide(motion, up)
	
func flip ():
	if $FrontFlip.is_colliding():
		motion.x *= -1

func attack () :
	self.call_deferred("_call_deferred_attack")
	
func _call_deferred_attack ():
	randomize()
	var wait_before_attack = randi() % 6
	yield(get_tree().create_timer(wait_before_attack), "timeout")

	if $RayAttack.is_colliding() and not is_attacking:		
		is_attacking = true	
		$AnimationPlayer.play("action")
		
func _CM_init_action_animation ():
	motion.x = 0
	
func _CM_action_attack ():
	$AttackArea/CollisionShape2D.disabled = false
	
func _CM_end_attack ():
	$AttackArea/CollisionShape2D.disabled = true

func _CM_finish_action_animation ():
	if self:
		get_parent().get_node("BringerOfDeath").is_cast_spell = false
		self.queue_free()

