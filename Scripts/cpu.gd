extends "res://Scripts/paddle.gd"

@onready var ball = $"../Ball"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_use == "yes":
		move(delta)

func move(delta):
	if ball.position.y > position.y:
		position.y += paddle_speed * delta
	if ball.position.y < position.y:
		position.y -= paddle_speed * delta
	clamp_paddle()
