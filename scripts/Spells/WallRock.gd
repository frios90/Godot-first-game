extends KinematicBody2D
const gravity                    = 250

var motion                       = Vector2(0, 0)
const up                         = Vector2(0, -1)
var level = 1
var attack = 30
var dead  = false
var life = 500
var base_defense                 = 100
onready var defense              = base_defense if level == 1 else base_defense * (level * 0.55)
onready var current_life         = life if level == 1 else life * (level * 0.77)         
 


func _cm_end_book () :
	self.queue_free()


func _on_DeadArea_area_entered(area):
	print(area)
	if area.is_in_group("Sword"):		
		Util.get_an_script("Camera2D").trauma = true
		if (dead == false):
			current_life = current_life - Players._get_attack(defense)
		if current_life <= 0:
			if (dead == false):
				$AnimationPlayer.play("boom")
				dead =  true
				
	if area.is_in_group("SandSpirit"):		
		Util.get_an_script("Camera2D").trauma = true
		$AnimationPlayer.play("boom")
		dead =  true
