extends Area2D

signal ball_trapped

@onready var main = $".."

func _on_body_entered(body):
	if body == $"../Ball":
		$BallDetectionTimer.start()



func _on_body_exited(body):
	if body == $"../Ball":
		$BallDetectionTimer.stop()


func _on_ball_detection_timer_timeout():
	main.new_round()
	ball_trapped.emit()
