extends Node2D

var number_message = 1
var msg_box  

func _ready():
	if Msgs.dlg_001.is_done:
		$OldMan.queue_free()
	$CanvasLayer.changeBackMusic2("res://sfx/background_wind_chimes_loop.wav", -10)
	$CanvasLayer.changeBackMusic("res://sfx/05 gaseous tethanus.ogg", 0)
	if Players.selected.change_scene_from_dead :
		$knight.position.x = Players.selected.last_save_point.x
		$knight.position.y = Players.selected.last_save_point.y
		Players.selected.change_scene_from_dead = false
	elif Env.player_origin_position == "init":
		$knight.position.x = 220
		$knight.position.y = 912
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _process(_delta):
	if Msgs.dlg_001.is_done :
		Msgs.forgot    = false
		Msgs.in_dialog = false
	else:
		if not Msgs.forgot and Msgs.in_dialog:		
			if Input.is_action_just_pressed("attack"):
				self.showMessages()
				Msgs.forgot = true

func initDialog () :
		Msgs.in_dialog      = true
		Msgs.dlg_001.active = true	
		$knight/Camera2D.position.x += 50
		
func showMessages () :
	if number_message < Msgs.dlg_001.msgs.size():
		if self.msg_box:
			self.msg_box.queue_free()
		self.msg_box  = self.addChildPlayerMsgBox()
		self.msg_box._set_message(Msgs.dlg_001.msgs[number_message])		
	else:
		if not Msgs.dlg_001.is_done:
			$knight/Camera2D.position.x -= 50
			self.msg_box.queue_free()
			Msgs.in_dialog       = false
			Msgs.dlg_001.is_done = true
			var item = ItemsGbl._get_item_by_code(1001)
			Players._add_item(item, 10)
			$Areas/InitDialogOldMan/CollisionShape2D/BtnToPress.visible = false
			$OldMan.go_on("R")
	number_message += 1
	
func addChildPlayerMsgBox():
	var box = load("res://scenes/GUI/MsgBoxA.tscn")
	box = box.instance()
	box.position.x = $knight.position.x + 55
	box.position.y = $knight.position.y + 70
	
	self.add_child(box)
	return box

func _on_Tutorial001_area_entered(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial001/BtnToPress.visible = true
func _on_Tutorial001_area_exited(area):
	if area.is_in_group("Player"):
		$Tutorials/Tutorial001/BtnToPress.visible = false
func _on_Tutorial002_area_entered(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial002/BtnToPress.visible = true
func _on_Tutorial002_area_exited(area):
	if area.is_in_group("Player"):
		$Tutorials/Tutorial002/BtnToPress.visible = false		
func _on_Tutorial003_area_entered(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial003/BtnToPress.visible = true
func _on_Tutorial003_area_exited(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial003/BtnToPress.visible = false	
func _on_Tutorial004_area_entered(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial004/BtnToPress.visible = true
func _on_Tutorial004_area_exited(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial004/BtnToPress.visible = false
func _on_Tutorial006_area_entered(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial006/BtnToPress.visible = true
func _on_Tutorial006_area_exited(area):
	if area.is_in_group("Player"):	
		$Tutorials/Tutorial006/BtnToPress.visible = false


func _on_InitDialogOldMan_body_entered(body):
	if body.get_name() == 'knight':
		if not Msgs.dlg_001.is_done:
			$Areas/InitDialogOldMan/CollisionShape2D/BtnToPress.visible = true
			$knight.idle()
			self.initDialog()

