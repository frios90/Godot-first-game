extends Area2D

func _ready():
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if area.is_in_group("Player"):
		var canvasLayer = get_tree().get_root().find_node("CanvasLayer", true,false)	
		canvasLayer.handleStartFigthingBoss()
	pass # Replace with function body.
