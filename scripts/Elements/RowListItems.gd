extends Label

var item

func _on_TextureButton_pressed():
	Util.get_an_script("MenuPause").info_item_selected                    = self.item
	Util.get_an_script("MenuPause").get_node("InfoItem").visible          = true
	Util.get_an_script("MenuPause").get_node("InfoItem/Title").text       = self.item.data.name
	Util.get_an_script("MenuPause").get_node("InfoItem/Description").text = self.item.data.description
	Util.get_an_script("MenuPause").get_node("InfoItem/Icon").texture     = load(self.item.data.icon)

func _on_TextureButton_mouse_entered():
	$Sprite.scale.x = 1.5
	$Sprite.scale.y = 1.5

func _on_TextureButton_mouse_exited():
	$Sprite.scale.x = 1
	$Sprite.scale.y = 1
