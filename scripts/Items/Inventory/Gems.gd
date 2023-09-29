extends KinematicBody2D

onready var motion = Vector2(0,0)
onready var up     = Vector2(0, -1)
export var color   = "blue"
export var qty     = 1

func _ready():
	var gem = str("res://assets/Items/" + color + ".png")
	$Sprite.texture = load(gem)
	var timer_gem = get_tree().create_timer(10)
	timer_gem.connect("timeout", self, "_end_gems")	
	
func _process(delta):
	
	motion.y += 10 * delta
	Env.non_use = move_and_slide(motion, up)
	
func _gems_pick_up ():	
	Util.get_an_script("CanvasLayer").handleGemCollected(qty)
	self._increment_exp_player(qty)
	queue_free()
	

func _end_gems ():
	self.queue_free()

func _increment_exp_player(points):
	Players.selected.stats.experience += points
	
	if  Players.selected.stats.experience >=  Players.selected.stats.next_level:

		Players.selected.stats.level      += 1
		Players.selected.stats.next_level = Players.selected.stats.next_level + (Players.selected.stats.next_level * 0.8)

		Players.selected.stats.strength   *= 1.2
		Util.get_an_script("CanvasLayer").get_node("LevelUp").visible = true
		Util.get_an_script("CanvasLayer").get_node("LevelUp/AnimationPlayer").play("upd")
		Util.get_an_script("CanvasLayer").handleSetLevelInUiPlayer()
