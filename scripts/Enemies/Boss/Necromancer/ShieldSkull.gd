extends Node2D

var skulls = 3

func _ready():
	$Skull.start   = true
	yield(get_tree().create_timer(.65), "timeout")
	$Skull2.start   = true
	yield(get_tree().create_timer(.65), "timeout")
	$Skull3.start   = true


func _process(delta):
	if self.get_child_count() == 0:		
		self.hurt_necromancer()
		self.queue_free()


func hurt_necromancer ():
	Util.get_an_script("Necromancer").has_shield = false
	Util.get_an_script("Camera2D").trauma = true
	Util.get_an_script("Necromancer").applySoundSword()			
	if (Util.get_an_script("Necromancer").dead == false):
		Util.get_an_script("Necromancer").current_life = Util.get_an_script("Necromancer").current_life - Players._get_attack(Util.get_an_script("Necromancer").defense)
		Util.get_an_script("Necromancer").state_machine.travel("hurt")	
		Util.get_an_script("Necromancer").ftd = Util.get_an_script("Necromancer").floating_text.instance()
		Util.get_an_script("Necromancer").ftd.type = "damage"
		Util.get_an_script("Necromancer").ftd.flip = Util.get_an_script("Necromancer").motion.x
		Util.get_an_script("Necromancer").ftd.true_positon_sprite = Util.get_an_script("Necromancer").true_positon_sprite
		Util.get_an_script("Necromancer").ftd.amount = Players._get_attack(Util.get_an_script("Necromancer").defense)
		add_child(Util.get_an_script("Necromancer").ftd)
		Util.get_an_script("CanvasLayer").handleUpdateHpBarBoss(Util.get_an_script("Necromancer").life, Util.get_an_script("Necromancer").current_life)
	if Util.get_an_script("Necromancer").current_life <= 0:
		if (Util.get_an_script("Necromancer").dead == false):
			Util.get_an_script("Necromancer").dead =  true			
			Util.get_an_script("Necromancer").state_machine.travel("dead")
			Util.get_an_script("knight")._increment_exp_player(Util.get_an_script("Necromancer").ptsDead)
			Env._dropGems(Util.get_an_script("Necromancer").position, 12)
