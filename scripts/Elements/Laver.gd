extends KinematicBody2D

var pull = false

func _ready():
	print("hola laver")

func _callMethodFinishPull ():
	$AudioPull.playing = true

func _on_AreaPull_area_entered(area):
	if area.is_in_group("Sword") and not pull:		
		$AnimationPlayer.play("pull")
		pull = true
