extends Node2D

var num_msg_wind = 1

var speed_text    = 0.08
var end_first_msg = false

var box_msg  

func _ready():
	pass # Replace with function body.


func _process(delta):
	if not Msgs.forgot and Msgs.in_dialog:		
		if Input.is_action_just_pressed("attack") and not Msgs.dlg_005.is_done:
			self.show_msgs_wind_spirit()
			Msgs.forgot = true

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
	$InitBattleWindSpirit.queue_free()
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

#Wind spirit
func _on_InitBattleWindSpirit_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.wind_spirit.dead:
			self.call_deferred("_cd_init_battle_wind_spirit")
			self.init_wind_dialog()

func _cd_init_battle_wind_spirit ():
	$CanvasLayer.changeBackMusic("res://sfx/wind.mp3", -2)	
	$InitBattleWindSpirit.queue_free()
	$ObeliskWindSpirit/CollisionShape2D.disabled = false
	$ObeliskWindSpirit/AnimationPlayer.play("action")
	$WaterSpirit.jump()

		
func _cd_finish_battle_wind_spirit () :
	$CanvasLayer.changeBackMusic("res://sfx/success_sound.wav", -1)
	$ObeliskWindSpirit/CollisionShape2D.disabled = true
	$ObeliskWindSpirit/AnimationPlayer.play("off")
	$WindSpirit._dead()

func init_wind_dialog () :
#	$Actions/Dialog001Boss/BtnToPress.visible = true
	Msgs.in_dialog      = true
	Msgs.dlg_005.active = true

func show_msgs_wind_spirit () :
	if self.num_msg_wind <  Msgs.dlg_005.msgs.size():
		if self.box_msg:
			self.box_msg.queue_free()
		self.box_msg  = self.addChildBoxMsg()
		self.box_msg._set_message( Msgs.dlg_005.msgs[self.num_msg_wind])
	else:
		self.box_msg.queue_free()
		Msgs.in_dialog       = false				
		Msgs.forgot          = false
		Msgs.dlg_005.is_done = true
		var item             = ItemsGbl._get_item_by_code(1026)
		Players._add_item(item, 1)
		self.call_deferred("_cd_finish_battle_wind_spirit")
		
	num_msg_wind += 1

func addChildBoxMsg():
	var box        = load("res://scenes/GUI/MsgBoxA.tscn")
	box            = box.instance()
	box.position.x = $knight.position.x 
	box.position.y = $knight.position.y + 20
	self.add_child(box)
	return box
