extends Node2D

func _ready():
	if Players.selected.change_scene_from_dead :
		$knight.position.x = Players.selected.last_save_point.x
		$knight.position.y = Players.selected.last_save_point.y
		Players.selected.change_scene_from_dead = false
	elif Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	elif Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _on_EnterBattle_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.bringer_of_deadth_001.dead:
			self.call_deferred("_cd_init_battle")
		
func _cd_init_battle ():
	$CanvasLayer.changeBackMusic("res://sfx/12 final battle.ogg", -20)
	$BringerOfDeath.withMoveAndFlip = 1
	$BringerOfDeath.motion.x = $BringerOfDeath.maxSpeed
	$Areas/EnterBattle.queue_free()
	$BossObelisk/CollisionShape2D.disabled = false
	$BossObelisk/AnimationPlayer.play("action")
	$BossObelisk2/CollisionShape2D.disabled = false
	$BossObelisk2/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	
func _finish_battle () :
	self.call_deferred("_cd_finish_battle")
		
func _cd_finish_battle () :
	$CanvasLayer.changeBackMusic("res://sfx/01 game-game_0.ogg", -20)	
	$BossObelisk/CollisionShape2D.disabled = true
	$BossObelisk/AnimationPlayer.play("off")
	$BossObelisk2/CollisionShape2D.disabled = true
	$BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false


