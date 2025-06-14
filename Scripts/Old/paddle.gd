extends StaticBody2D

@export var side : GlobalEnums.PaddleSide
@export var controller : GlobalEnums.PaddleController

@onready var ball = $"../Ball"

#initialise variables
var paddle_speed = 500

var width = 64
var height = 192
var center = Vector2(round(width/2), round(height/2))

func _ready():
	if side:
		set_side()

func _process(delta):
	if GlobalVariables.game_status == GlobalEnums.GameStatus.RUNNING:
		move(delta)
		position.y = clamp(position.y, 0 + center.y, GlobalConfigs.screen_size.y - center.y)
		
# move paddle up
func move_up(delta):
	position.y -= paddle_speed * delta

# move paddle down
func move_down(delta):
	position.y += paddle_speed * delta

func set_side() -> void:
	match side:
		GlobalEnums.PaddleSide.LEFT:
			$Sprite2D.flip_h = false
			$CollisionPolygon2D.rotation = 0
		GlobalEnums.PaddleSide.RIGHT:
			$Sprite2D.flip_h = true
			$CollisionPolygon2D.rotation = deg_to_rad(180)

func move(delta) -> void:
	match controller:
		GlobalEnums.PaddleController.PLAYER_1:
			if Input.is_action_pressed("player1_up"):
				move_up(delta)
			if Input.is_action_pressed("player1_down"):
				move_down(delta)
		GlobalEnums.PaddleController.PLAYER_2:
			if Input.is_action_pressed("player2_up"):
				move_up(delta)
			if Input.is_action_pressed("player2_down"):
				move_down(delta)
		GlobalEnums.PaddleController.CPU:
			if ball.direction.x > 0:
				if ball.position.y > position.y + (center.y / 2):
					move_down(delta)
				if ball.position.y < position.y - (center.y / 2):
					move_up(delta)

