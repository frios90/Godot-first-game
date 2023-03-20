extends Camera2D

export (float, 0 , 1) var decaimiento = 30.0 ##esto mas el noise seed  actualizadose en el _process puede causar un gran temblor. Para esto bajar valor de decaimiento
export var max_offetr: Vector2 = Vector2(80, 80)
export var max_rotation: float = 0.1

var trauma: float = 0
var max_trauma    = 4

var noise_y : float

onready var noise: OpenSimplexNoise = OpenSimplexNoise.new()

func _ready () :
	randomize()	
	noise.period = 6

func _process(delta):
	noise.seed = randi()
	if trauma:
		trauma = max(trauma- (decaimiento * delta), 0)
		comenzar()
		 
func sacudir (cantidad) :
	trauma = min(trauma + cantidad, 1.0)
	
func comenzar ():
	var cantidad = pow(trauma, max_trauma)
	noise_y = +1
	rotation = max_rotation * cantidad * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offetr.x * cantidad * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = max_offetr.y * cantidad * noise.get_noise_2d(noise.seed * 2, noise_y)
	
	
	
