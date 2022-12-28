extends Node2D

func _on_EnterBattle_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.bringer_of_deadth_001.dead:
			self.call_deferred("_cd_init_battle")
		
func _cd_init_battle ():
	$CanvasLayer/BackAudio.stop()
	$CanvasLayer/BackAudio.stream = load(DbBoss.bringer_of_deadth_001._battleAudio)
	$CanvasLayer/BackAudio.play()
	$BringerOfDeath.withMoveAndFlip = 1
	$BringerOfDeath.motion.x = $BringerOfDeath.maxSpeed
	$Areas/EnterBattle.queue_free()
	$collision/BossObelisk/CollisionShape2D.disabled = false
	$collision/BossObelisk/AnimationPlayer.play("action")
	$collision/BossObelisk2/CollisionShape2D.disabled = false
	$collision/BossObelisk2/AnimationPlayer.play("action")
	$CanvasLayer/HPBarBoss.visible  = true
	$CanvasLayer/CircleBoss.visible = true
	
func _finish_battle () :
	self.call_deferred("_cd_finish_battle")
	
func _cd_finish_battle () :
	$CanvasLayer/BackAudio.stop()
	$CanvasLayer/BackAudio.stream = load(DbBoss.winner_song)
	$CanvasLayer/BackAudio.play()
	
	$collision/BossObelisk/CollisionShape2D.disabled = true
	$collision/BossObelisk/AnimationPlayer.play("off")
	$collision/BossObelisk2/CollisionShape2D.disabled = true
	$collision/BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/HPBarBoss.visible  = false
	$CanvasLayer/CircleBoss.visible = false
