extends "res://Scripts/paddle.gd"

# onready
@onready var ball = $"../Ball"
@onready var main = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if a singleplayer game is in progress move
	if main.game_status == Global.GameStatus.IN_PROGRESS and main.game_mode == Global.GameMode.SINGLEPLAYER and ball.direction.x > 0:
		move(delta)

# move towards the ball if the ball is travelling towards the paddle
func move(delta):
	if ball.position.y > position.y + (center.y / 2):
		position.y += paddle_speed * delta
	if ball.position.y < position.y - (center.y / 2):
		position.y -= paddle_speed * delta
	clamp_paddle()
