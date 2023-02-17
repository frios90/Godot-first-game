extends Node

var doors = [
	{
		"code" : 001,
		"for_open_key" : 1040,
		"key"  : 0,
		"name" : "church-door",
		"open" : false
	}
]

func _get_door_by_code(code):
	for i in range(len(self.doors)):
		if self.doors[i].code == code :
			return self.doors[i]
