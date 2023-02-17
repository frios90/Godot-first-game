extends Node

var points = [
	{
		"key"  : 0,
		"code" : 001,
		"name" : "Pasaje de la cueva",
		"scene" : "res://scenes/World/Cementery/Cementery-003-down-of-hill.tscn",
		"x" : 1648,
		"y" : 500,
		"status" : false
	},
	{
		"key"  : 1,
		"code" : 002,
		"name" : "Inicio",
		"scene" : "res://scenes/World/Cementery/Cementery-001-intro.tscn",
		"x" : 4920,
		"y" : 336,
		"status" : false
	}
]


func _get_save_point_code(code):
	for i in range(len(self.points)):
		if self.points[i].code == code :
			return self.points[i]
