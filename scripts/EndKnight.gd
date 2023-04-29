extends KinematicBody2D
var floating_text          = preload("res://scenes/FloatingText.tscn")
var ftd                    = 0
const up                   = Vector2(0, -1)
var attack_area_position_y = -43
var attack_area_position_x = -12
var dead_area_position_y   = 2
var dead_area_position_x   = -1
var dead_area_scale_x      = 1
var dead_area_scale_y      = 1.1
var collision_position_x   = 0
var collision_position_y   = 0.5
var collision_scale_x      = 1
var collision_scale_y      = 0.52
var timer_dead             = 0
var time_lapsus_dead       = 150
var motion                 = Vector2(0, 0)
var max_jump               = 2
var times_jump             = 0
var lapsus_step            = 23
var is_healing             = false
var is_jumping             = false
var is_attacking           = false
var is_dashing             = false
var is_hurting             = false
var is_climbing            = false
var is_walking             = false
var going_up               = false
var going_down             = false
var can_pray               = false
var is_praying             = false
var in_hand_pray           = ""
var can_open_chest         = false
var in_front_of_the_chest  = ""
var can_open_door         = false
var can_validate_enter_portal = false
var in_front_of_the_door  = ""

var timer_not_take_damage     = 0
var time_loop_not_take_damage = 60
var timer_pray                = 500

var timer_dash = 0 #PARCHE PARA NO QUEDAR CON EL DASH ACTIVO
var limit_dash = 10 # 40 es 0.6seg aprox -- 5 = 0.15

var event_attack   = 0
var timer_attack   = 0
var limit_attack   = 20

var limit_disabled_collision_down_climb = 10
var timer_disabled_collision_down_climb = 0

var _delta = 0
var state_machine
func _ready():
	print(Players.selected.stats.next_level + (Players.selected.stats.next_level * 1.1) )
	state_machine = $AnimationTree.get("parameters/playback")	
	state_machine.travel("idle")
	
func _process(delta):	
	motion.y = -5
	
	Env.non_use = move_and_slide(motion, up)
	
