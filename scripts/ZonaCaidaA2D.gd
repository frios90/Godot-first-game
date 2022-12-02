extends Area2D

func _on_Area2D_body_entered(body):
	if body.get_name() == 'knight':	
		var reload = get_tree().reload_current_scene()
		print(reload)
