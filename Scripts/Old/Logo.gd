extends Sprite2D

# variable declarations
var width = 256
var height = 160
var center = Vector2(width/2, height/2)

var in_out_direction = Global.InOutDirection.OUT
const TWEEN_LENGTH = 4

# activates when enters scene tree
func _ready():
	reset_logo()
	$LogoTimer.wait_time = TWEEN_LENGTH
	tween_logo()
	

# reset logo to default state
func reset_logo():
	scale = Vector2(1.2,1.2)
	rotation = 0
	show()

# change scale and rotation direction
func _on_logo_timer_timeout():
	tween_logo()


func _on_visibility_changed():
	if is_visible():
		reset_logo()

func tween_logo():
	var tween = get_tree().create_tween()
	var scale_range
	$LogoTimer.start()
	match in_out_direction:
		GlobalEnums.InOutDirection.IN:
			scale_range = randf_range(1.1, 1.2)
			tween.tween_property($".", "scale", Vector2(scale_range, scale_range), TWEEN_LENGTH)
			tween.parallel().tween_property($".", "rotation", deg_to_rad(randf_range(-10, 0)), TWEEN_LENGTH)
			in_out_direction = GlobalEnums.InOutDirection.OUT
		GlobalEnums.InOutDirection.OUT:
			scale_range = randf_range(1.2, 1.3)
			tween.tween_property($".", "scale", Vector2(scale_range, scale_range), TWEEN_LENGTH)
			tween.parallel().tween_property($".", "rotation", deg_to_rad(randf_range(0, 10)), TWEEN_LENGTH)
			in_out_direction = GlobalEnums.InOutDirection.IN
