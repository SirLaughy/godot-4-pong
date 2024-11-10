extends Node2D

@onready var sfx_game_over = $sfx_gameOver
@onready var sfx_point_scored = $sfx_pointScored
@onready var sfx_button_click = $sfx_buttonClick
@onready var sfx_paddle_collision = $sfx_paddleCollision
@onready var sfx_wall_collision = $sfx_wallCollision

func play_sound(sound):
	sound.pitch_scale = randf_range(0.8, 1.2)
	sound.play()
