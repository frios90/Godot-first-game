extends Area2D

func _on_WaterBoss_body_entered(body):

	if body.get_name() == 'knight' and $CollisionShape2D.disabled == false:	
		var reload = get_tree().reload_current_scene()
		print(reload)
