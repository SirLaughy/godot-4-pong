extends CanvasLayer
@onready var main = get_parent()

# Called when the node enters the scene tree for the first time.

# initialise score to 0 abd hide uneeded HUD elements
func _ready():
	$Score1.text = str(0)
	$Score2.text = str(0)
	$Message.hide()
	$PauseMenu.hide()

# hide new game button and show the game selection buttons
func _on_new_game_pressed():
	$"New Game".hide()
	$Singleplayer.show()
	$Multiplayer.show()

# quit game
func _on_quit_pressed():
	get_tree().quit()

# initialise new game in singleplayer mode
func _on_singleplayer_pressed():
	main.game_mode = Global.GameMode.SINGLEPLAYER
	new_game()

# initialise new game in multiplayer mode
func _on_multiplayer_pressed():
	main.game_mode = Global.GameMode.MULTIPLAYER
	new_game()

# initialise variables and HUD elements for a new game
func new_game():
	$Logo.hide()
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
	main.game_status = Global.GameStatus.IN_PROGRESS

# hide message after a time
func _on_message_timer_timeout():
	$Message.hide()

# initialise the menu after a game ends
func initialise_menu():
	$Logo.reset_logo()
	$"New Game".show()
	$Quit.show()

# end game and return to main menu
func _on_end_game_pressed():
	main.game_over()
	$Message.hide()
	$PauseMenu.hide()

# resume game from pause
func _on_resume_game_pressed():
	main.pause_unpause()
