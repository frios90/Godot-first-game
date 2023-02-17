extends Node2D

var mini001_start = false

func _process(delta):
	if self.get_child_count() == 0:
		self.queue_free()
	
	if not self.mini001_start:
		self.mini001_start = true
		var bloodI = load("res://scenes/Enemies/BloodInvoque.tscn")
		self.create_blood_effect(bloodI,  $MiniNecromancer)
		self.create_blood_effect(bloodI,  $MiniNecromancer2)
		
func create_blood_effect (bloodI, skeleton):
	var blood = bloodI.instance()
	blood.position.x = skeleton.position.x
	blood.position.y = skeleton.position.y
	add_child(blood)
	
