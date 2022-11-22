extends Area2D

func _on_GoTo_body_entered(body):
	if body.get_name() == 'knight':	
		get_tree().change_scene("res://scenes/Etapas/Etapa1.tscn")
