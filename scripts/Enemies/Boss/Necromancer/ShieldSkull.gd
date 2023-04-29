extends Node2D
var skulls = 3

func _ready():
	$Skull.start   = true
	yield(get_tree().create_timer(.65), "timeout")
	$Skull2.start   = true
	yield(get_tree().create_timer(.65), "timeout")
	$Skull3.start   = true

func _process(_delta):
	if self.get_child_count() == 0:		
		self.hurt_necromancer()
		self.queue_free()

func hurt_necromancer ():
	Util.get_an_script("Necromancer")._recive_hurt()

