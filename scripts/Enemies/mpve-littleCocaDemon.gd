extends PathFollow2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("go-attack")
