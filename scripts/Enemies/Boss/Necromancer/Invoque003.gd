extends Node2D

var skeleton001_start = false

func _process(delta):
	if self.get_child_count() == 0:
		self.queue_free()
	
	if not self.skeleton001_start:
		self.skeleton001_start = true
		var bloodI = load("res://scenes/Enemies/BloodInvoque.tscn")
		self.create_blood_effect(bloodI,  $"Skeleton-003")
		self.create_blood_effect(bloodI,  $"Skeleton-004")
		self.create_blood_effect(bloodI,  $"Skeleton-005")
		self.create_blood_effect(bloodI,  $"Skeleton-006")
		
func create_blood_effect (bloodI, skeleton):
	var blood = bloodI.instance()
	blood.position.x = skeleton.position.x
	blood.position.y = skeleton.position.y
	add_child(blood)
	
