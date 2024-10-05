extends "res://Scripts/paddle.gd"

@onready var ball = $"../Ball"
@onready var main = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main.game_status == Main.GameStatus.IN_PROGRESS and main.game_mode == Main.GameMode.SINGLEPLAYER and ball.direction.x > 0:
		move(delta)

func move(delta):
	if ball.position.y > position.y + (center.y / 2):
		position.y += paddle_speed * delta
	if ball.position.y < position.y - (center.y / 2):
		position.y -= paddle_speed * delta
	clamp_paddle()
