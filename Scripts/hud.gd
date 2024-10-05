extends CanvasLayer
@onready var main = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score1.text = str(0)
	$Score2.text = str(0)
	$Message.hide()
	$PauseMenu.hide()
	

func _on_new_game_pressed():
	$"New Game".hide()
	$Singleplayer.show()
	$Multiplayer.show()

func _on_quit_pressed():
	get_tree().quit()


func _on_singleplayer_pressed():
	main.game_mode = Main.GameMode.SINGLEPLAYER
	new_game()

func _on_multiplayer_pressed():
	main.game_mode = Main.GameMode.MULTIPLAYER
	new_game()

func new_game():
	$Title.hide()
	$Quit.hide()
	$Singleplayer.hide()
	$Multiplayer.hide()
	main.score = [0,0]
	$Score1.text = str(main.score[0])
	$Score2.text = str(main.score[1])
	$Message.text = "First to 7 Wins"
	$Message.show()
	$MessageTimer.start()
	main.new_round()
	main.game_status = Main.GameStatus.IN_PROGRESS
	

func _on_message_timer_timeout():
	$Message.hide()

func initialise_menu():
	$Title.show()
	$"New Game".show()
	$Quit.show()
	




func _on_end_game_pressed():
	main.game_over()
	$Message.hide()
	$PauseMenu.hide()


func _on_resume_game_pressed():
	main.pause_unpause()
