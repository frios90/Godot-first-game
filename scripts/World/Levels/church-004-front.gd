extends Node2D
var code = 001
func _ready():
	if Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y
	if Env.player_origin_position == "church":
		$knight.position.x = 624
		$knight.position.y = 520

func _process(delta):	
	var door_in_open = Doors._get_door_by_code(self.code)
	if door_in_open.open:
		Doors.doors[door_in_open.key].open = false
		Env.player_origin_position = "init"	
		Env.non_use = get_tree().change_scene("res://scenes/World/Church/Church-007-inside.tscn")

func _on_ChurchDoor_area_entered(area):
	if area.is_in_group("Player"):
		$ChurchDoor/CollisionShape2D/BtnToPress.visible = true
		
func _on_ChurchDoor_area_exited(area):
	if area.is_in_group("Player"):
		$ChurchDoor/CollisionShape2D/BtnToPress.visible = false
		if self.has_node("MsgBoxA"):				
			self.get_node("MsgBoxA").queue_free()
