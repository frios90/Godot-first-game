extends Node
var init = 1000
var list = [
	{
		"key"    : 0,
		"code"   : 1001,
		"open"   : false
	},
	{
		"key"    : 1,
		"code"   : 1002,
		"open"   : false
	},
	{
		"key"    : 2,
		"code"   : 1003,
		"open"   : false
	},
	{
		"key"    : 3,
		"code"   : 1004,
		"open"   : false
	},
	{
		"key"    : 4,
		"code"   : 1005,
		"open"   : false
	},
	{
		"key"    : 5,
		"code"   : 1006,
		"open"   : false
	},
	{
		"key"    : 6,
		"code"   : 1007,
		"open"   : false
	},
	{
		"key"    : 7,
		"code"   : 1008,
		"open"   : false
	},
	{
		"key"    : 8,
		"code"   : 1009,
		"open"   : false
	},
	{
		"key"    : 9,
		"code"   : 1010,
		"open"   : false
	},
	{
		"key"    : 10,
		"code"   : 1011,
		"open"   : false
	},
	{
		"key"    : 11,
		"code"   : 1012,
		"open"   : false
	},
	{
		"key"    : 12,
		"code"   : 1013,
		"open"   : false
	}
]

func _get_chest_by_code(code):
	for i in range(len(self.list)):
		if self.list[i].code == code :
			return self.list[i]
