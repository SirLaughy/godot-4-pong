extends StaticBody2D

# onready
@onready var screen_size = get_viewport_rect().size

#initialise variables
var paddle_speed = 500

var width = 64
var height = 192
var center = Vector2(round(width/2), round(height/2))

# prevent paddle from going outside the screen 
func clamp_paddle():
	position.y = clamp(position.y, 0 + center.y, screen_size.y - center.y)
