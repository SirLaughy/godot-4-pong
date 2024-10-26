extends Node

class_name Global_Config

const SAVEFILE = "user://nimbusballconfig.save"

var sfx_volume : int
var music_volume : int
var screen_shake_level : int

# TODO: Keybind Mapping
# TODO: Audio Channel

func _ready():
	load_config()

func load_config():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		sfx_volume = file.get_32()
		music_volume = file.get_32()
		screen_shake_level = file.get_32()
	else:
		sfx_volume = 100
		music_volume = 100
		screen_shake_level = 100
	
func save_config():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_32(sfx_volume)
	file.store_32(music_volume)
	file.store_32(screen_shake_level)
	file = null
