extends Node2D

#onready
@onready var ball = $Ball
@onready var paddle1 = $Paddle1
@onready var paddle2 = $Paddle2

@onready var hud = $HUD


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.scene_gameScene.connect(scene_gameScene)
	GlobalSignals.New_Game.connect(new_game)
	GlobalSignals.scene_mainMenu.connect(scene_mainMenu)
	GlobalConfigs.screen_size = get_viewport_rect().size
	SceneManager.set_scene()

# checking for pause button press
func _input(_event):
	if Input.is_action_just_pressed("player1_pause") || Input.is_action_just_pressed("player2_pause"):
		match SceneManager.current_scene:
			GlobalEnums.GameScenes.MAIN_MENU:
				pass
			GlobalEnums.GameScenes.GAME_SCENE:
				SceneManager.push_scene(GlobalEnums.GameScenes.PAUSE_MENU)
			GlobalEnums.GameScenes.PAUSE_MENU:
				$HUD/PauseMenu.hide()
				SceneManager.pop_stack()
			GlobalEnums.GameScenes.OPTIONS_MENU:
				$HUD/OptionsMenu.hide()
				SceneManager.pop_stack()

func new_game():
	match GlobalVariables.game_mode:
		GlobalEnums.GameMode.SINGLEPLAYER:
			paddle2.controller = GlobalEnums.PaddleController.CPU
		GlobalEnums.GameMode.MULTIPLAYER:
			paddle2.controller = GlobalEnums.PaddleController.PLAYER_2
	new_round()

# reset positions of paddle and ball for a new round
func new_round():
	ball.speed = ball.initial_speed
	paddle1.position = Vector2(50 + paddle1.center.x, GlobalConfigs.screen_size.y / 2)
	ball.position = Vector2(GlobalConfigs.screen_size.x / 2, GlobalConfigs.screen_size.y/2)
	ball.rotation_speed = ball.initial_rotation_speed
	
	paddle2.position = Vector2(GlobalConfigs.screen_size.x - 50 - paddle2.center.x, GlobalConfigs.screen_size.y / 2)

	paddle1.show()
	paddle2.show()
	ball.direction = Vector2.ZERO
	ball.show()
	$BallTimer.start()

# increase right hand GlobalVariables.score
func _on_screen_left_body_entered(_body):
		GlobalVariables.score[1] += 1
		$HUD/Scores/Score2.text = str(GlobalVariables.score[1])
		check_score()

# increase left hand GlobalVariables.score
func _on_screen_right_body_entered(_body):
		GlobalVariables.score[0] += 1
		$HUD/Scores/Score1.text = str(GlobalVariables.score[0])
		check_score()

# move the ball in a random direction
func _on_ball_timer_timeout():
	ball.random_direction()

# display winner and return to main menu
func game_over():
	if GlobalVariables.game_mode == GlobalEnums.GameStatus.RUNNING:
		$HUD/Message.text = check_winner() + " wins!"
		$HUD/Message.show()
	GlobalVariables.game_status = GlobalEnums.GameStatus.STOPPED
	SceneManager.set_stack(GlobalEnums.GameScenes.MAIN_MENU)

# return who is the winner
func check_winner():
	if GlobalVariables.game_mode == GlobalEnums.GameMode.SINGLEPLAYER:
		if GlobalVariables.score[0] > 6:
			return "Player"
		if GlobalVariables.score[1] > 6:
			return "CPU"
	if GlobalVariables.game_mode == GlobalEnums.GameMode.MULTIPLAYER:
		if GlobalVariables.score[0] > 6:
			return "Player 1"
		if GlobalVariables.score[1] > 6:
			return "Player 2"

# check if there is a winner
func check_score():
	if GlobalVariables.score[0] < 7 and GlobalVariables.score[1] < 7:
		new_round()
	else:
		game_over()

func scene_gameScene():
	GlobalVariables.game_status = GlobalEnums.GameStatus.RUNNING

func scene_mainMenu() -> void:
	new_round()
