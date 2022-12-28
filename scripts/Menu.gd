extends Control

func _ready():
	pass # Replace with function body.


func _on_InitButtom_pressed():
		Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")
