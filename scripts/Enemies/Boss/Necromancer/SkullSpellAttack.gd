extends KinematicBody2D

var attack       = 45

var is_attacking = false
var parent_position

var limitTimerLap = 25
var timerLap      = 24
var useTween      = 1
var current_life  = 1
var speed         = 100
var start         = false

func _ready():
	pass
#	$AnimationPlayer.play("action")

func _process(_delta):
	if self.start:
		self.lap()

func lap ():
	self.timerLap += 1
	if self.timerLap == self.limitTimerLap:
		if self.useTween == 1 :
			$Tween.stop(self)
			$Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + Vector2(speed, speed), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			self.useTween = 2
		elif self.useTween == 2 :
			$Tween.stop(self)
			$Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + Vector2(speed, -speed), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			self.useTween = 3
		elif self.useTween == 3:
			$Tween.stop(self)
			$Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + Vector2(-speed, -speed), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			self.useTween = 4
		elif self.useTween == 4 :
			$Tween.stop(self)
			$Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + Vector2(-speed, speed), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			self.useTween = 1			
		self.timerLap = 0
	
func _on_DeadArea_area_entered(area):
	if area.is_in_group("Sword") and self.start:		
		print("hit ")
		Util.get_an_script("Camera2D").trauma = true
		get_parent().skulls -= 1
		self.queue_free()
