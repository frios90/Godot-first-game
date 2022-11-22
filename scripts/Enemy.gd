extends Area2D

var dead = false;

func _ready():
	pass
	
func _process(_delta):
	if dead == false:
		$AnimatedSprite.play("Idle")


func _on_Enemy_area_entered(area):
	if area.is_in_group("Sword"):
		dead =  true
		print("muerte")
		$AnimatedSprite.play("Killed")
		

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Killed":
		queue_free()
