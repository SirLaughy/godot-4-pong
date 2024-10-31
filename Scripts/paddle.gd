extends StaticBody2D

#initialise variables
var paddle_speed = 500

var width = 64
var height = 192
var center = Vector2(round(width/2), round(height/2))

# prevent paddle from going outside the screen 
func clamp_paddle():
	position.y = clamp(position.y, 0 + center.y, GlobalConfigs.screen_size.y - center.y)

# move paddle up
func move_up(delta):
	position.y -= paddle_speed * delta

# move paddle down
func move_down(delta):
	position.y += paddle_speed * delta
