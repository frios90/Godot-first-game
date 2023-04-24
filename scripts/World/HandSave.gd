extends KinematicBody2D

export (int) var spt_code = 001
var just_ready = false

func _process(_delta):
	if not just_ready:
		for pt in SavePoints.points:
			if int(pt.code) == int(spt_code):
				if SavePoints.points[pt.key].status:
					just_ready = true
					$AnimationPlayer.play("on")
