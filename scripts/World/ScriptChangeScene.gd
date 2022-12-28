extends Area2D

func _on_Goto002001_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 104
		Env.init_position_stage.y = 440
		Env.init_position_stage.flip = -1
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-002-bridge.tscn")

func _on_Rtn001002_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 6810
		Env.init_position_stage.y = 525
		Env.init_position_stage.flip = -1
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")

func _on_Goto003002_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 72
		Env.init_position_stage.y = 528
		Env.init_position_stage.flip = -1
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn")


func _on_Rtn002003_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 8328
		Env.init_position_stage.y = 360
		Env.init_position_stage.flip = -1
		Env.non_use =  get_tree().change_scene("res://scenes/World/Cementery/Cementery-002-bridge.tscn")

func _on_Goto004003_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 4000
		Env.init_position_stage.y = -1136
		Env.init_position_stage.flip = -1
		Env.non_use =  get_tree().change_scene("res://scenes/World/Church/church-004-front.tscn")

func _on_Rtn003004_body_entered(body):
	if body.get_name() == 'knight':	
		Env.init_position_stage.x = 4000
		Env.init_position_stage.y = -1136
		Env.init_position_stage.flip = -1
		Env.non_use =  get_tree().change_scene("res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn")



