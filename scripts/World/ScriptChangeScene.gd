extends Area2D

func _on_Goto002001_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-002-bridge.tscn")

func _on_Rtn001002_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"		
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")

func _on_Goto003002_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn")


func _on_Rtn002003_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Cementery/Cementery-002-bridge.tscn")

func _on_Goto004003_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Church/church-004-front.tscn")

func _on_Rtn003004_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn")

func _on_Goto005004_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/PassTown/PassTown-005-enter.tscn")

func _on_Goto006005_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "init"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/PassTown/PassTown-006-town.tscn")


func _on_Rtn004005_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/Church/church-004-front.tscn")


func _on_Goto007006_body_entered(body):
	pass # Replace with function body.


func _on_Rtn005006_body_entered(body):
	if body.get_name() == 'knight':	
		Env.player_origin_position = "return"	
		Env.non_use =  get_tree().change_scene("res://scenes/World/PassTown/PassTown-005-enter.tscn")
