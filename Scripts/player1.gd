extends "res://Scripts/paddle.gd"

# onready
@onready var main = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# only move if game is in progress
	if main.game_status == Global.GameStatus.IN_PROGRESS:
		move(delta)

# move player 1 paddle up/down according to input
func move(delta):
	if Input.is_action_pressed("player1_down"):
		position.y += paddle_speed * delta
	if Input.is_action_pressed("player1_up"):
		position.y -= paddle_speed * delta
	clamp_paddle()
