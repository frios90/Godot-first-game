extends Node2D


func _ready():
	print("script de la etapa")

func _process(delta):

	if($LaverPullLadder.pull):
		print("escalera activa")
