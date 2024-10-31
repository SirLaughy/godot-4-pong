extends "res://Scripts/paddle.gd"

# onready
@onready var main = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# only move if game is in progress
	if GlobalVariables.game_status == GlobalEnums.GameStatus.RUNNING:
		move(delta)

# move player 1 paddle up/down according to input
func move(delta):
	if Input.is_action_pressed("player1_down"):
		move_down(delta)
	if Input.is_action_pressed("player1_up"):
		move_up(delta)
	clamp_paddle()
