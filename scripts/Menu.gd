extends Control

func _ready():
	$CanvasLayer.visible  = false	
	$CanvasLayer.changeBackMusic("res://sfx/13 the end.ogg", 0)
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		self._on_InitButtom_pressed()
	
func _on_InitButtom_pressed():
	Env.non_use = get_tree().change_scene("res://scenes/World/Cementery/Cementery-001-intro.tscn")
