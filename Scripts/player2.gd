extends "res://Scripts/paddle.gd"

# onready
@onready var main = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# only move if game is running and gamemode is multiplayer
	if GlobalVariables.game_status == GlobalEnums.GameStatus.RUNNING:
		if GlobalVariables.game_mode == GlobalEnums.GameMode.MULTIPLAYER:
			move(delta)

# move player 2 paddle up/down depending on input
func move(delta):
	if Input.is_action_pressed("player2_down"):
		move_down(delta)
	if Input.is_action_pressed("player2_up"):
		move_up(delta)
	clamp_paddle()
