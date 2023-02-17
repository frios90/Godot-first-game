extends Node2D
var code = 001
func _ready():
	if Env.player_origin_position == "init":
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y
	if Env.player_origin_position == "return":
		$knight.position.x = $EndArrow.position.x - 100
		$knight.position.y = $EndArrow.position.y

func _process(delta):
	var door_in_open = Doors._get_door_by_code(self.code)
	if door_in_open.open:
		Doors.doors[door_in_open.key].open = false
		$knight.position.x = $InitArrow.position.x + 100
		$knight.position.y = $InitArrow.position.y

func _on_ChurchDoor_area_entered(area):
	if area.is_in_group("Player"):
		$ChurchDoor/CollisionShape2D/BtnToPress.visible = true
		


func _on_ChurchDoor_area_exited(area):
	if area.is_in_group("Player"):
		$ChurchDoor/CollisionShape2D/BtnToPress.visible = false
