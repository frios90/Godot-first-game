extends Node
var town_name = "Pueblo"
var final_boss_name = "Nicromante"
var name_other_world = "upDownSIde"
var in_dialog = false

var non_use
var list_gems = [
	{
		"color": "gold",
		"qty"  : 500
	},
	{
		"color": "red",
		"qty"  : 200
	},
	{
		"color": "calipso",
		"qty"  : 120
	},
	{
		"color": "orange",
		"qty"  : 90
	},
	{
		"color": "pink",
		"qty"  : 60
	},
	{
		"color": "green",
		"qty"  : 30
	},
	{
		"color": "blue",
		"qty"  : 1
	},
]

var player_origin_position = "init"

var init_position_stage = {
	"x" : 224,
	"y" : -150,
	"flip" : 1
}

var coins       = 0
var points      = 0


	

func _dropGems (position, max_gem_drop):
	randomize()
	var random_max_gem = randi() % max_gem_drop 
	selectDropGem(random_max_gem, position)
		
func selectDropGem (gems, position) :

	for i in range(list_gems.size()):
		if gems >= list_gems[i].qty:			
			createGem(list_gems[i].color, (gems / list_gems[i].qty), position, list_gems[i].qty) 
			gems = gems % list_gems[i].qty			
		

func createGem (color, gems, position,  qty) :
	
	for _i in range(gems):
		randomize()
		var random_position_gem = randi() % 2 
		var random_x            = randi() % 35	
		var random_y            = randi() % 35							
		var drop_gem            = load("res://scenes/Items/Gem.tscn")	
		drop_gem                = drop_gem.instance()
		drop_gem.position.x     = position[0] + random_x if random_position_gem == 1 else position[0] - random_x
		drop_gem.position.y     = position[1] + random_y if random_position_gem == 1 else position[1] - random_y	
		drop_gem.color          = color
		drop_gem.qty            = qty

		yield(get_tree().create_timer(0.05), "timeout")	
		get_parent().add_child(drop_gem)
