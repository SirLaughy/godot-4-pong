extends "res://Scripts/paddle.gd"

@onready var main = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main.game_status == Main.GameStatus.IN_PROGRESS:
		move(delta)

func move(delta):
	if Input.is_action_pressed("player1_down"):
		position.y += paddle_speed * delta
	if Input.is_action_pressed("player1_up"):
		position.y -= paddle_speed * delta
	clamp_paddle()
