extends KinematicBody2D
 
var attack    = 50
var in_action = false

func _ready():
	pass # Replace with function body.

func _callMethodTrapOpen ():
	$KillArea/CollisionShape2D.disabled = false
	$SoundClose.playing = true

func _callMethodTrapClose ():
	$KillArea/CollisionShape2D.disabled = true
	$DamageArea/CollisionShape2D.disabled = false	
	in_action = false


func _callMethodTrapEnd ():
	$AnimationPlayer.play("off")
	in_action = false

func _process(_delta):
	if ($RayUp.is_colliding() or $RayUp2.is_colliding() or $RayUp3.is_colliding()) and not in_action:
		$AnimationPlayer.play("action")
		$DamageArea/CollisionShape2D.disabled = true
		in_action = true

func _on_DamageArea_body_entered(body):
	if body.is_in_group("Player"):		
		attack = 50

func _on_KillArea_body_entered(body):
	if body.is_in_group("Player"):		
		attack = 100
