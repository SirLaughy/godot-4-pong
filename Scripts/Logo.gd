extends Sprite2D

# variable declarations
var width = 256
var height = 160
var center = Vector2(width/2, height/2)

var in_out_direction = Global.InOutDirection.OUT
var in_out_speed = 0.05
var rotation_direction = Global.Direction.RIGHT
var rotation_speed = 0.001

# activates when enters scene tree
func _ready():
	reset_logo()

# reset logo to default state
func reset_logo():
	scale = Vector2(1.2,1.2)
	rotation = 0
	$LogoTimer.wait_time = 3
	show()

# scale and rotate the logo in and out
func _process(delta):
	if in_out_direction == Global.InOutDirection.IN:
		scale -= Vector2(in_out_speed, in_out_speed) * delta
	else:
		scale += Vector2(in_out_speed, in_out_speed) * delta
		
	if rotation_direction == Global.Direction.LEFT:
		rotation -= rotation_speed
	else:
		rotation += rotation_speed
		
	scale.x = clamp(scale.x, 0.5, 2)
	scale.y = clamp(scale.y, 0.5, 2)
	rotation = clamp(rotation, -10, 10)

# change scale and rotation direction
func _on_logo_timer_timeout():
	if in_out_direction == Global.InOutDirection.IN:
		in_out_direction = Global.InOutDirection.OUT
	elif in_out_direction == Global.InOutDirection.OUT:
		in_out_direction = Global.InOutDirection.IN
	
	if rotation_direction == Global.Direction.LEFT:
		rotation_direction = Global.Direction.RIGHT
	elif rotation_direction == Global.Direction.RIGHT:
		rotation_direction = Global.Direction.LEFT

	$LogoTimer.wait_time = randf_range(2.5, 3.5)
	$LogoTimer.start()


func _on_visibility_changed():
	if is_visible():
		reset_logo()
