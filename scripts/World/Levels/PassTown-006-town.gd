extends Node2D

var dead_last_invoque = false

func _ready():
	if Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _on_EnterBattle_body_entered(body):
	if body.get_name() == 'knight':
		if not DbBoss.bringer_of_deadth_001.dead:
			self.call_deferred("_cd_init_battle")

func _cd_init_battle ():
	if not DbBoss.necromancer_002.dead:
	#	$CanvasLayer/BackAudio.stop()
	#	$CanvasLayer/BackAudio.stream = load(DbBoss.bringer_of_deadth_001._battleAudio)
	#	$CanvasLayer/BackAudio.play()
	#	$Necromancer.motion.x = $Necromancer.maxSpeed
		$Areas/EnterBattle.queue_free()
		$BossObelisk/CollisionShape2D.disabled = false
		$BossObelisk/AnimationPlayer.play("action")
		$BossObelisk2/CollisionShape2D.disabled = false
		$BossObelisk2/AnimationPlayer.play("action")
		$CanvasLayer/BossBarControl.visible  = true
		$CanvasLayer/BossBarControl.visible = true

func _finish_battle () :
	self.call_deferred("_cd_finish_battle")
		
func _cd_finish_battle () :
#	$CanvasLayer/BackAudio.stop()
#	$CanvasLayer/BackAudio.stream = load(DbBoss.winner_song)
#	$CanvasLayer/BackAudio.play()	
	
	$BossObelisk/CollisionShape2D.disabled = true
	$BossObelisk/AnimationPlayer.play("off")
	$BossObelisk2/CollisionShape2D.disabled = true
	$BossObelisk2/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false
