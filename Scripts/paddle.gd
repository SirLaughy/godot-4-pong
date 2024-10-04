extends StaticBody2D

@onready var screen_size = get_viewport_rect().size


enum direction{UP, DOWN, STOP}


var width = 32
var height = 128
var center = Vector2(width/2, height/2)
var paddle_speed = 300
var in_use = "no"
 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func clamp_paddle():
	position.y = clamp(position.y, 0 + center.y, screen_size.y - center.y)
