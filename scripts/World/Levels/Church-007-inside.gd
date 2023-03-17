extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

## FLAME BATTLE
func _on_InitBattelFlameSpirit_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.flame_spirit.dead:
			self.call_deferred("_cd_init_battle_flame_spirit")
		
func _cd_init_battle_flame_spirit ():
	$CanvasLayer.changeBackMusic("res://sfx/Batalla001.ogg", -25)	
	$InitBattelFlameSpirit.queue_free()
	$ObeliskFlameSpirit/CollisionShape2D.disabled = false
	$ObeliskFlameSpirit/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	
func _finish_battle_flame_spirit () :
	self.call_deferred("_cd_finish_battle_flame_spirit")
		
func _cd_finish_battle_flame_spirit () :
	$CanvasLayer.changeBackMusic("res://sfx/success_sound.wav", -1)
	$ObeliskFlameSpirit/CollisionShape2D.disabled = true
	$ObeliskFlameSpirit/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false

##SAND BATTLE
func _on_InitBattleSandSpirit_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.sand_spirit.dead:
			self.call_deferred("_cd_init_battle_sand_spirit")

func _cd_init_battle_sand_spirit ():
	$CanvasLayer.changeBackMusic("res://sfx/Batalla001.ogg", -25)	
	$InitBattleSandSpirit.queue_free()
	$ObeliskSandSpirit/CollisionShape2D.disabled = false
	$ObeliskSandSpirit/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true

func _finish_battle_sand_spirit () :
	self.call_deferred("_cd_finish_battle_sand_spirit")
		
func _cd_finish_battle_sand_spirit () :
	$CanvasLayer.changeBackMusic("res://sfx/success_sound.wav", -1)
	$ObeliskSandSpirit/CollisionShape2D.disabled = true
	$ObeliskSandSpirit/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false

## WATER BATTLE
func _on_InitBattleWaterSpirit_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.water_spirit.dead:
			self.call_deferred("_cd_init_battle_water_spirit")

func _cd_init_battle_water_spirit ():
	$CanvasLayer.changeBackMusic("res://sfx/Batalla001.ogg", -25)	
	$InitBattleWaterSpirit.queue_free()
	$ObeliskWaterSpirit/CollisionShape2D.disabled = false
	$ObeliskWaterSpirit/AnimationPlayer.play("action")
	$CanvasLayer/BossBarControl.visible  = true
	$WaterSpirit.jump()

func _finish_battle_water_spirit () :
	self.call_deferred("_cd_finish_battle_water_spirit")
		
func _cd_finish_battle_water_spirit () :
	$CanvasLayer.changeBackMusic("res://sfx/success_sound.wav", -1)
	$ObeliskWaterSpirit/CollisionShape2D.disabled = true
	$ObeliskWaterSpirit/AnimationPlayer.play("off")
	$CanvasLayer/BossBarControl.visible  = false
