extends Node2D

class_name Main

enum GameMode{SINGLEPLAYER, MULTIPLAYER}
enum GameStatus{IN_PROGRESS, ENDED, PAUSED}

@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var cpu = $CPU
@onready var ball = $Ball
@onready var screen_size = get_viewport_rect().size
@onready var hud = $HUD

var game_mode := GameMode.SINGLEPLAYER
var score = [0,0]
var game_status = GameStatus.ENDED

# Called when the node enters the scene tree for the first time.
func _ready():
	initialise_menu()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pause_unpause()
		
func new_round():
	player2.hide()
	cpu.hide()
	ball.speed = ball.initial_speed	
	player1.position = Vector2(50 + player1.center.x, screen_size.y / 2)
	ball.position = Vector2(screen_size.x / 2, screen_size.y/2)
	ball.rotation_speed = ball.initial_rotation_speed
	
	if game_mode == GameMode.MULTIPLAYER:
		player2.position = Vector2(screen_size.x - 50 - player2.center.x, screen_size.y / 2)
		cpu.position = Vector2(screen_size.x * 2, 0)
		player2.show()

	else:
		cpu.position = Vector2(screen_size.x - 50 - cpu.center.x, screen_size.y / 2)
		player2.position = Vector2(screen_size.x * 2, 0)
		cpu.show()
	ball.direction = Vector2.ZERO
	ball.show()
	$BallTimer.start()

func _on_screen_left_body_entered(_body):
		score[1] += 1
		$HUD/Score2.text = str(score[1])
		check_score()

func _on_screen_right_body_entered(_body):
		score[0] += 1
		$HUD/Score1.text = str(score[0])
		check_score()

func _on_ball_timer_timeout():
	ball.random_direction()

func game_over():
	if game_status == GameStatus.IN_PROGRESS:
		$HUD/Message.text = check_winner() + " wins!"
		$HUD/Message.show()
	game_status = GameStatus.ENDED
	hud.initialise_menu()
	initialise_menu()

	
func initialise_menu():
	ball.position = Vector2(screen_size.x / 2, screen_size.y/2)
	ball.direction = Vector2.ZERO
	
	player1.position = Vector2(50 + player1.center.x, screen_size.y / 2)
	player2.position = Vector2(screen_size.x - 50 - player2.center.x, screen_size.y / 2)
	cpu.position = Vector2(screen_size.x - 50 - cpu.center.x, screen_size.y / 2)

	$BallTimer.stop()
	
func check_winner():
	if game_mode == GameMode.SINGLEPLAYER:
		if score[0] > 6:
			return "Player"
		if score[1] > 6:
			return "CPU"
	if game_mode == GameMode.MULTIPLAYER:
		if score[0] > 6:
			return "Player 1"
		if score[1] > 6:
			return "Player 2"

func check_score():
	if score[0] < 7 and score[1] < 7:
		new_round()
	else:
		game_over()
	
func pause_unpause():
	if game_status == GameStatus.IN_PROGRESS:
		$HUD/Message.text = "Paused"
		$HUD/Message.show()
		$HUD/PauseMenu.show()
		$HUD/Title.show()
		game_status = GameStatus.PAUSED
	elif game_status == GameStatus.PAUSED:
		$HUD/Message.hide()
		$HUD/PauseMenu.hide()
		$HUD/Title.hide()
		game_status = GameStatus.IN_PROGRESS	
