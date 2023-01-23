extends KinematicBody2D

export (int) var code = 1001 # code del chest
export (int) var item = 1002 # code del item
export (int) var qty  = 1    # qty del item
var procc             = true

func _ready ():
	self.item = ItemsGbl._get_item_by_code(self.item)
	if Chests._get_chest_by_code(code).open :
		self.procc = false 
		$AnimationPlayer.play("open-001")		

func _process(delta):

	if self.procc:
		var chest = Chests._get_chest_by_code(code)
		if chest.open and self.procc:
			self.procc = false
			$AnimationPlayer.play("open-001")			
			Players._add_item(self.item, self.qty)

			Util.get_an_script("CanvasLayer").get_node("PopUpItem/LabelItem").text = self.item.name
			Util.get_an_script("CanvasLayer").get_node("PopUpItem").visible        = true
			
			var timer_popup = get_tree().create_timer(2)
			timer_popup.connect("timeout", self, "hidePopUpItem")	
			
func hidePopUpItem ():
	Util.get_an_script("CanvasLayer").get_node("PopUpItem").visible = false
