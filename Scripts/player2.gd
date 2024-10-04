extends "res://Scripts/paddle.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_use == "yes":
		move(delta)

func move(delta):
	if Input.is_action_pressed("player2_down"):
		position.y += paddle_speed * delta
	if Input.is_action_pressed("player2_up"):
		position.y -= paddle_speed * delta
	clamp_paddle()
