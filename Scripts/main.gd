extends Node2D

enum gamemode{SINGLEPLAYER, MULTIPLAYER}

@onready var player1 = $Player1
@onready var player2 = $Player2
@onready var cpu = $CPU
@onready var ball = $Ball
@onready var screen_size = get_viewport_rect().size
@onready var hud = $HUD

var chosen_gamemode = gamemode.SINGLEPLAYER
@onready var score = [0,0]
var running = "no"

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.position = Vector2(screen_size.x / 2, screen_size.y/2)
	player1.position = Vector2(50 + player1.center.x, screen_size.y / 2)
	player2.position = Vector2(screen_size.x - 50 - player2.center.x, screen_size.y / 2)
	cpu.position = Vector2(screen_size.x - 50 - cpu.center.x, screen_size.y / 2)
	player2.hide()
	$BallTimer.stop()
	ball.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("space"):
		new_round()
	

func new_round():
	player2.hide()
	cpu.hide()
	ball.speed = ball.initial_speed
			
	player1.position = Vector2(50 + player1.center.x, screen_size.y / 2)
	ball.position = Vector2(screen_size.x / 2, screen_size.y/2)
	
	if chosen_gamemode == gamemode.MULTIPLAYER:
		player2.position = Vector2(screen_size.x - 50 - player2.center.x, screen_size.y / 2)
		player2.show()
		player2.in_use = "yes"

	else:
		cpu.position = Vector2(screen_size.x - 50 - cpu.center.x, screen_size.y / 2)
		cpu.show()
		cpu.in_use = "yes"
	ball.direction = Vector2.ZERO
	$BallTimer.start()

func _on_screen_left_body_entered(body):
		score[1] += 1
		$HUD/Score2.text = str(score[1])
		new_round()


func _on_screen_right_body_entered(body):
		score[0] += 1
		$HUD/Score1.text = str(score[0])
		new_round()


func _on_ball_timer_timeout():
	ball.random_direction()


func new_game():
	pass
