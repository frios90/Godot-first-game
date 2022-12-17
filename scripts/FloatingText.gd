extends Position2D

var amount = 0
var type   = ""
var true_positon_sprite = true
var flip  = 1
var velocity = Vector2(0,0)

func _ready ():
	$NodeLabel/Label.text = String(amount)
	randomize()
	var side_movement = randi() % 121 - 60 
	match type:
		"heal":
			$NodeLabel/Label.set("custom_colors/font_color", Color("00e906"))
			velocity = Vector2(side_movement, 25)
		"damage":
			$NodeLabel/Label.set("custom_colors/font_color", Color("ff3131"))
			print(flip)
			flip = 1 if flip <= 0 else -1
			$NodeLabel.scale.x *=  flip if true_positon_sprite else flip * -1
			velocity = Vector2(side_movement, 25)

	
	
	$Tween.interpolate_property(self, 'scale', scale, Vector2(1,1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_property(self, 'scale', Vector2(1,1), Vector2(0.1,0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	$Tween.start()

func _process(delta):

	position += velocity * delta

func _on_Tween_tween_all_completed():
	self.queue_free()
