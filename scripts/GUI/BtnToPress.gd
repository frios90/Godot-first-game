extends KinematicBody2D

export var inpt = "c"

func _ready():
	
	

	match self.inpt:
		"c": $Sprite.texture = load("res://assets/Gui/btns/green-C.png")
		"x": $Sprite.texture = load("res://assets/Gui/btns/red-X.png")
		"up": $Sprite.texture = load("res://assets/Gui/btns/UP.png")
		"xup": $Sprite.texture = load("res://assets/Gui/btns/xUP.png")
		"z": $Sprite.texture = load("res://assets/Gui/btns/z.png")
		"p": $Sprite.texture = load("res://assets/Gui/btns/p.png")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
