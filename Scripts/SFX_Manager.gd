extends Node2D

@onready var sfx_game_over = $sfx_gameOver
@onready var sfx_point_scored = $sfx_pointScored

const DEFAULT_GAME_OVER = 0.0
const DEFAULT_POINT_SCORED = 0.0

var sfx_default_volumes : Dictionary

func _ready():
	configure_dictionary()

func play_sound(sound):
	sound.pitch_scale = randf_range(0.8, 1.2)
	#sound.volume = sfx_default_volumes[sound] * GlobalConfigs.sfx_volume
	sound.play() 

func configure_dictionary():
	sfx_default_volumes = {
		sfx_game_over : DEFAULT_GAME_OVER,
		sfx_point_scored : DEFAULT_POINT_SCORED
	}
