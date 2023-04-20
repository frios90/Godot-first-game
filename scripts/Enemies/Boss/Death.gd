extends KinematicBody2D

var state_machine

var act_001 = {
	'done' : false
}

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	self.state_machine.start("off")

func init_act_001 ():
	self.state_machine.travel("init")

func attack_act_001 ():
	self.state_machine.travel("attack")

func gone_act_001 ():
	self.state_machine.travel("end")
