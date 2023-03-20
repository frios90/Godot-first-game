extends KinematicBody2D

var attack    = 50
var in_action = false
var shoot_timer = 75
var shoot       = 0
var power_shoot  = 70
var speed_shoot = -250
export (int) var dir_projectile = -1

func _process(_delta):
	if self.shoot > 0: 
		self.shoot += 1
		if self.shoot == self.shoot_timer:
			self.shoot = 0
	if $RayAttack.is_colliding() and self.shoot == 0:
		$AnimationPlayer.play("attack")
		self.shoot = 1


func _callMethodStartAttack () :
	var projectile = load("res://scenes/Spells/Projectile002.tscn")
	projectile = projectile.instance()
	projectile.position.x = self.position.x + (20 * self.dir_projectile)
	projectile.position.y = self.position.y + 1
	projectile.maxSpeed   = self.speed_shoot if dir_projectile < 0 else self.speed_shoot * -1
	projectile.attack     = self.power_shoot 
	projectile.scale.x    *= self.dir_projectile
	print(scale.x)
	get_parent().add_child(projectile)
