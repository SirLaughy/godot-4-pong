extends "res://Scripts/paddle.gd"

# onready
@onready var main = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# only move if game is running and gamemode is multiplayer
	if main.game_status == Global.GameStatus.IN_PROGRESS:
		if main.game_mode == Global.GameMode.MULTIPLAYER:
			move(delta)

# move player 2 paddle up/down depending on input
func move(delta):
	if Input.is_action_pressed("player2_down"):
		position.y += paddle_speed * delta
	if Input.is_action_pressed("player2_up"):
		position.y -= paddle_speed * delta
	clamp_paddle()
