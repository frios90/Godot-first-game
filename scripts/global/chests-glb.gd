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
	},
	{
		"key"    : 13, ##key iglesia
		"code"   : 1014,
		"open"   : false
	},
	{
		"key"    : 14,
		"code"   : 1015,
		"open"   : false
	},
	{
		"key"    : 15,
		"code"   : 1016,
		"open"   : false
	},
	{
		"key"    : 16,
		"code"   : 1017,
		"open"   : false
	},
	{
		"key"    : 17,
		"code"   : 1018,
		"open"   : false
	},
	{
		"key"    : 18,
		"code"   : 1019,
		"open"   : false
	},
	{
		"key"    : 19,
		"code"   : 1020,
		"open"   : false
	},
	{
		"key"    : 20,
		"code"   : 1021,
		"open"   : false
	},
	{
		"key"    : 21,
		"code"   : 1022,
		"open"   : false
	},
	{
		"key"    : 22,
		"code"   : 1023,
		"open"   : false
	},
	{
		"key"    : 23,
		"code"   : 1024,
		"open"   : false
	},
	{
		"key"    : 24,
		"code"   : 1025,
		"open"   : false
	},
	{
		"key"    : 25,
		"code"   : 1026,
		"open"   : false
	},
	{
		"key"    : 26,
		"code"   : 1027,
		"open"   : false
	},
	{
		"key"    : 27,
		"code"   : 1028,
		"open"   : false
	},
	{
		"key"    : 28,
		"code"   : 1029,
		"open"   : false
	},
	{
		"key"    : 29,
		"code"   : 1030,
		"open"   : false
	}
]

func _get_chest_by_code(code):
	for i in range(len(self.list)):
		if self.list[i].code == code :
			return self.list[i]
