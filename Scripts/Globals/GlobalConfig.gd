extends Node

class_name Global_Config

const SAVEFILE = "user://nimbusballconfig.save"

var sfx_volume : float
var music_volume : float
var screen_shake_level : float
var screen_size : Vector2

# TODO: Keybind Mapping
# TODO: Audio Channel

func _ready():
	load_config()

func load_config():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		sfx_volume = file.get_var(sfx_volume)
		music_volume = file.get_var(music_volume)
		screen_shake_level = file.get_var(screen_shake_level)
	else:
		sfx_volume = 1.0
		music_volume = 1.0
		screen_shake_level = 1.0
	
func save_config():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(sfx_volume)
	file.store_var(music_volume)
	file.store_var(screen_shake_level)
	file = null
