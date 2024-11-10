extends CanvasLayer
@onready var main = get_parent()

# Called when the node enters the scene tree for the first time.

# initialise score to 0 and hide uneeded HUD elements
func _ready():
	$Scores/Score1.text = str(0)
	$Scores/Score2.text = str(0)
	$Message.hide()
	$PauseMenu.hide()
	GlobalSignals.New_Game.connect(new_game)

# initialise variables and HUD elements for a new game
func new_game():
	GlobalVariables.score = [0,0]
	$Scores/Score1.text = str(GlobalVariables.score[0])
	$Scores/Score2.text = str(GlobalVariables.score[1])
	message("First to 7 Wins")
	$Scores.show()
	SfxManager.play_sound(SfxManager.sfx_button_click)

# hide message after a time
func _on_message_timer_timeout():
	$Message.hide()
	
func message(message_text):
	$Message.text = str(message_text)
	$Message.show()
	$Message/MessageTimer.start()
	
func _on_ball_trapped_detection_ball_trapped():
	message("Ball Trapped")
