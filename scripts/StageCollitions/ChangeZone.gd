extends Area2D

func _on_GoTo_body_entered(body):
	if body.get_name() == 'knight':	
#		Env.init_position_stage.x = 848
#		Env.init_position_stage.y = -80
#		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/Etapas/Etapa1.tscn")

func _on_GoToCave01_body_entered(body):
	if body.get_name() == 'knight':
		get_tree().change_scene("res://scenes/Etapas/Etapa1-Caverna01.tscn")

func _on_GoToEtapa1Part2_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = -1579
		Env.init_position_stage.y = -81
		get_tree().change_scene("res://scenes/Etapas/Etapa1-parte2.tscn")
		
func _on_GoToEnterBridge_body_entered(body):	
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 72
		Env.init_position_stage.y = 56
		Env.init_position_stage.flip = 1
		get_tree().change_scene("res://scenes/Etapas/Etapa1-bridge.tscn")


func _on_ReturnEtapa1Init_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 762
		Env.init_position_stage.y = -80
		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/Etapas/Etapa1.tscn")

# Etapa1-bridge a Etapa1-parte2
func _on_ReturnEtapa1Parte2desdeBridge_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 1293
		Env.init_position_stage.y = -241
		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/Etapas/Etapa1-parte2.tscn")

#Desde el final del puente al frontis de la iglesia
func _on_GoToFrontChurchFromBridge_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 200
		Env.init_position_stage.y = 21
		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/Etapas/Etapa1-front-church.tscn")

#desde el frontis de la iglesia hasta el final del puente
func _on_ReturnToBridgeFromFrontChurch_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 2624
		Env.init_position_stage.y = 56
		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/Etapas/Etapa1-bridge.tscn")
