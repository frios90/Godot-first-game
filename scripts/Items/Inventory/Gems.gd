extends KinematicBody2D

onready var motion = Vector2(0,0)
onready var up   = Vector2(0, -1)
export var color  = "blue"
export var qty    = 1

func _ready():
	var gem = str("res://assets/Items/" + color + ".png")
	$Sprite.texture = load(gem)
	
func _process(delta):
	motion.y += 75 * delta
	Env.non_use = move_and_slide(motion, up)
	
func _gems_pick_up ():
	$SoundPickAGem.playing = true
	yield(get_tree().create_timer(0.09), "timeout")	
	Util.get_an_script("CanvasLayer").handleGemCollected(qty)
	queue_free()


