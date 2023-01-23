extends Node2D

func _ready():
	if Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
#		$knight.position.x = 2080
		$knight.position.y = $InitArrow.position.y
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y


func _on_EnterBattle_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.bringer_of_deadth_001.dead:
			self.call_deferred("_cd_init_battle")

func _cd_init_battle ():
#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.bringer_of_deadth_001._battleAudio)
#	$CanvasLayer/BackAudio.play()

#	$Necromancer.motion.x = $Necromancer.maxSpeed
	$Areas/EnterBattle.queue_free()
	$collision/BossObelisk/CollisionShape2D.disabled = false
	$collision/BossObelisk/AnimationPlayer.play("action")
	$collision/BossObelisk2/CollisionShape2D.disabled = false
	$collision/BossObelisk2/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	$CanvasLayer/BossBarControl.visible = true
