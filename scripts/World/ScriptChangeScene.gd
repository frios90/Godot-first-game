extends Area2D

func _on_Goto003from001_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn")

func _on_Rtn001from003_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")

func _on_Goto004003_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Church/church-004-front.tscn")

func _on_Rtn003004_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn")

func _on_Goto006from004_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/PassTown/PassTown-006-town.tscn")


func _on_Rtn004from006_body_entered (body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Church/church-004-front.tscn")

func _on_Rtn004from007_body_entered(body):
	
	if body.get_name() == 'knight':	
		Env.player_origin_position = "church"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Church/church-004-front.tscn")

