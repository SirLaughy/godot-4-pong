extends "res://Scripts/paddle.gd"

# onready
@onready var ball = $"../Ball"
@onready var main = get_parent()

# initialise variables
var free_movement = true
var ball_collisions = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if a singleplayer game is in progress move
	if main.game_status == Global.GameStatus.IN_PROGRESS and main.game_mode == Global.GameMode.SINGLEPLAYER and ball.direction.x > 0:
		if free_movement == true:
			move(delta)

# move paddle according to ball position
func move(delta):
	if ball.position.y > position.y + (center.y / 2):
		move_down(delta)
	if ball.position.y < position.y - (center.y / 2):
		move_up(delta)
	clamp_paddle()
