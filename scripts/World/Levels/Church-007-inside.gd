extends Node2D

var num_msg_wind = 1
var num_msg_old_man = 1

var speed_text    = 0.08

var box_msg  

func _ready():
	pass # Replace with function body.


func _process(delta):
	if not Msgs.forgot and Msgs.in_dialog:		
		if Input.is_action_just_pressed("attack") and not Msgs.dlg_006.is_done:
			self.show_msgs_old_man()
			Msgs.forgot = true
		elif Input.is_action_just_pressed("attack") and not Msgs.dlg_005.is_done:
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

#Wind spirit
func _on_InitBattleWindSpirit_body_entered(body):
	if body.get_name() == 'knight':			
		if not DbBoss.wind_spirit.dead:
			self.call_deferred("_cd_init_battle_wind_spirit")


func _cd_init_battle_wind_spirit ():
	$CanvasLayer.changeBackMusic("res://sfx/wind.mp3", -2)	
	$ObeliskWindSpirit/CollisionShape2D.disabled = false
	$ObeliskWindSpirit/AnimationPlayer.play("action")
	$WaterSpirit.jump()
	$InitBattleWindSpirit/CollisionShape2D/BtnToPress.visible = true
	$knight.idle()
	Msgs.in_dialog      = true
	Msgs.dlg_005.active = true

		
func _cd_finish_battle_wind_spirit () :
	$InitBattleWindSpirit.queue_free()
	$CanvasLayer.changeBackMusic("res://sfx/success_sound.wav", -1)
	$ObeliskWindSpirit/CollisionShape2D.disabled = true
	$ObeliskWindSpirit/AnimationPlayer.play("off")
	$WindSpirit._dead()

##dialogo con el viejo

func _on_InitOldManDialogArea_body_entered(body):
	if body.get_name() == 'knight':
		if not DbBoss.old_man.dead:
			self.init_old_man_dialog()

func  init_old_man_dialog() :
	$InitOldManDialogArea/CollisionShape2D/BtnToPress.visible = true
	$knight.idle()
	Msgs.in_dialog      = true
	Msgs.dlg_006.active = true

func show_msgs_old_man () :
	if self.num_msg_old_man <  Msgs.dlg_006.msgs.size():
		if self.box_msg:
			self.box_msg.queue_free()
		self.box_msg  = self.addChildBoxMsg(100, 80)
		self.box_msg._set_message( Msgs.dlg_006.msgs[self.num_msg_old_man])
		if Msgs.dlg_006.msgs[self.num_msg_old_man].issuing == "Death":
			if Msgs.dlg_006.msgs[self.num_msg_old_man].event == "init":
				$Death.init_act_001()
			if Msgs.dlg_006.msgs[self.num_msg_old_man].event == "attack":
				$Death.attack_act_001()	
			if Msgs.dlg_006.msgs[self.num_msg_old_man].event == "end-dialig":
				$Death.gone_act_001()		
		if Msgs.dlg_006.msgs[self.num_msg_old_man].issuing == "old-man":
			if Msgs.dlg_006.msgs[self.num_msg_old_man].event == "dead":
				$OldMan.dead()
	else:
		self.box_msg.queue_free()
		Msgs.in_dialog       = false				
		Msgs.forgot          = false
		Msgs.dlg_006.is_done = true
		var item             = ItemsGbl._get_item_by_code(1026)
		Players._add_item(item, 1)
		$InitOldManDialogArea/CollisionShape2D/BtnToPress.visible = false
		
	self.num_msg_old_man += 1


func show_msgs_wind_spirit () :
	if self.num_msg_wind <  Msgs.dlg_005.msgs.size():
		if self.box_msg:
			self.box_msg.queue_free()
		self.box_msg  = self.addChildBoxMsg(100, 75)
		self.box_msg._set_message( Msgs.dlg_005.msgs[self.num_msg_wind])
	else:
		$InitBattleWindSpirit.queue_free()
		self.box_msg.queue_free()
		Msgs.in_dialog       = false				
		Msgs.forgot          = false
		Msgs.dlg_005.is_done = true
		var item             = ItemsGbl._get_item_by_code(1026)
		Players._add_item(item, 1)
		self.call_deferred("_cd_finish_battle_wind_spirit")		
	num_msg_wind += 1

func addChildBoxMsg(x, y):
	var box        = load("res://scenes/GUI/MsgBoxA.tscn")
	box            = box.instance()
	box.position.x = $knight.position.x if not x else $knight.position.x + x
	box.position.y = $knight.position.y + y	
	self.add_child(box)
	return box

func _on_PortalAccess_area_entered(area):
	if area.is_in_group("Player"):
		$PortalAccess/CollisionShape2D/BtnToPress.visible = true

func _on_PortalAccess_area_exited(area):
	if area.is_in_group("Player"):
		$PortalAccess/CollisionShape2D/BtnToPress.visible = false
		if self.has_node("MsgBoxA"):				
			self.get_node("MsgBoxA").queue_free()
