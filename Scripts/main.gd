extends Node2D

#onready
@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var cpu = $CPU
@onready var ball = $Ball
@onready var screen_size = get_viewport_rect().size
@onready var hud = $HUD

# initialise variables
var game_mode := Global.GameMode.SINGLEPLAYER
var score = [0,0]
var game_status = Global.GameStatus.ENDED

# Called when the node enters the scene tree for the first time.
func _ready():
	initialise_menu()

# checking for pause button press
func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pause_unpause()

# reset positions of paddle and ball for a new round
func new_round():
	player2.hide()
	cpu.hide()
	ball.speed = ball.initial_speed	
	player1.position = Vector2(50 + player1.center.x, screen_size.y / 2)
	ball.position = Vector2(screen_size.x / 2, screen_size.y/2)
	ball.rotation_speed = ball.initial_rotation_speed
	
	#if multiplayer reset player 2 position
	if game_mode == Global.GameMode.MULTIPLAYER:
		player2.position = Vector2(screen_size.x - 50 - player2.center.x, screen_size.y / 2)
		cpu.position = Vector2(screen_size.x * 2, 0)
		player2.show()

#if singleplayer reset CPU position
	else:
		cpu.position = Vector2(screen_size.x - 50 - cpu.center.x, screen_size.y / 2)
		player2.position = Vector2(screen_size.x * 2, 0)
		cpu.show()
	ball.direction = Vector2.ZERO
	ball.show()
	$BallTimer.start()

# increase right hand score
func _on_screen_left_body_entered(_body):
		score[1] += 1
		$HUD/Score2.text = str(score[1])
		check_score()

# increase left hand score
func _on_screen_right_body_entered(_body):
		score[0] += 1
		$HUD/Score1.text = str(score[0])
		check_score()

# move the ball in a random direction
func _on_ball_timer_timeout():
	ball.random_direction()

# display winner and return to main menu
func game_over():
	if game_status == Global.GameStatus.IN_PROGRESS:
		$HUD/Message.text = check_winner() + " wins!"
		$HUD/Message.show()
	game_status = Global.GameStatus.ENDED
	hud.initialise_menu()
	initialise_menu()

# reset paddle and ball positions and freeze movement
func initialise_menu():
	ball.position = Vector2(screen_size.x / 2, screen_size.y/2)
	ball.direction = Vector2.ZERO
	
	player1.position = Vector2(50 + player1.center.x, screen_size.y / 2)
	player2.position = Vector2(screen_size.x - 50 - player2.center.x, screen_size.y / 2)
	cpu.position = Vector2(screen_size.x - 50 - cpu.center.x, screen_size.y / 2)

	$BallTimer.stop()

# return who is the winner
func check_winner():
	if game_mode == Global.GameMode.SINGLEPLAYER:
		if score[0] > 6:
			return "Player"
		if score[1] > 6:
			return "CPU"
	if game_mode == Global.GameMode.MULTIPLAYER:
		if score[0] > 6:
			return "Player 1"
		if score[1] > 6:
			return "Player 2"

# check if there is a winner
func check_score():
	if score[0] < 7 and score[1] < 7:
		new_round()
	else:
		game_over()

# toggle pause status
func pause_unpause():
	# pause
	if game_status == Global.GameStatus.IN_PROGRESS:
		$HUD/Message.text = "Paused"
		$HUD/Message.show()
		$HUD/PauseMenu.show()
		$HUD/Logo.reset_logo()
		game_status = Global.GameStatus.PAUSED
		
	# unpause
	elif game_status == Global.GameStatus.PAUSED:
		$HUD/Message.hide()
		$HUD/PauseMenu.hide()
		$HUD/Logo.hide()
		game_status = Global.GameStatus.IN_PROGRESS	
