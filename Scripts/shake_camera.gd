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
	var amount = pow(trauma, trauma_power)
	rotation = (max_roll * amount * randf_range(-1, 1))
	offset.x = (max_offset.x * amount * randf_range(-1, 1))
	offset.y = (max_offset.y * amount * randf_range(-1, 1))
	
func add_trauma(amount : float):
		trauma = min(amount * GlobalConfigs.screen_shake_level, 1.0)
	
	
