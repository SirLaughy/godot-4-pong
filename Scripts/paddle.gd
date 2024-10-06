extends StaticBody2D

@onready var screen_size = get_viewport_rect().size


var width = 64
var height = 192
var center = Vector2(round(width/2), round(height/2))
var paddle_speed = 500

 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func clamp_paddle():
	position.y = clamp(position.y, 0 + center.y, screen_size.y - center.y)
