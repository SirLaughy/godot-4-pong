extends Camera2D

@export var decay : float = 0.8
@export var max_offset : Vector2 = Vector2(100, 75)
@export var max_roll : float = 0.1

var trauma : float = 0.0
var trauma_power : int = 2

func _ready():
	randomize()
	
func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
func shake():
	var config = Playerconfigs.screen_shake_level / 100
	var amount = pow(trauma, trauma_power)
	rotation = (max_roll * amount * randf_range(-1, 1)) * config
	offset.x = (max_offset.x * amount * randf_range(-1, 1)) * config
	offset.y = (max_offset.y * amount * randf_range(-1, 1)) * config
	
func add_trauma(amount : float):
		trauma = min(amount, 1.0)
	
	
