extends Area2D

func _on_Goto002001_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 104
		Env.init_position_stage.y = 440
		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/World/Cementery/Cementery-002-bridge.tscn")

func _on_Rtn001002_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 6810
		Env.init_position_stage.y = 525
		Env.init_position_stage.flip = -1
		get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")



