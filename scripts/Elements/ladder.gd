extends Area2D


func _ready():
	print("READY ENTERED DE LA ESCALA")


func _on_Area2D_body_entered(body):
	print(body)
	if body.is_in_group("LadderEnd"):
		print("Esta colicionando con la lader end")
