extends CanvasLayer
@onready var main = get_node("$..")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Score1.text = str(0)
	$Score2.text = str(0)
	$Message.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	$"New Game".hide()
	$Singleplayer.show()
	$Multiplayer.show()

func _on_quit_pressed():
	get_tree().quit()


func _on_singleplayer_pressed():
	
	#main.chosen_gamemode = SINGLEPLAYER
	new_game()

func _on_multiplayer_pressed():
	#main.chosen_gamemode = MULTIPLAYER
	new_game()

func new_game():
	$Title.hide()
	$Quit.hide()
	$Singleplayer.hide()
	$Multiplayer.hide()
	main.score = [0,0]
	$Score1.text = main.score[0]
	$Score2.text = main.score[1]
	$Message.text = "First to 7 Wins"
	$Message.show()
	$MessageTimer.start()
	main.new_round()
	main.running = "yes"
	

func _on_message_timer_timeout():
	$Message.hide()
