extends Area2D

func _on_GoTo_body_entered(body):
	if body.get_name() == 'knight':	
		print("paso por el area")
		get_tree().change_scene("res://scenes/Etapas/Etapa1.tscn")



func _on_GoToCave01_body_entered(body):
	print("ENTRO AQI")
	if body.get_name() == 'knight':	
		print("paso por el area")
		get_tree().change_scene("res://scenes/Etapas/Etapa1-Caverna01.tscn")
