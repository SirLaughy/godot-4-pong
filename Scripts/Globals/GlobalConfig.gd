extends Node

class_name Global_Config

const SAVEFILE 						= "user://nimbusballconfig.json"
var json_string


var sfx_volume 						: float
var music_volume 					: float
var screen_shake_level 				: float
var screen_size 					: Vector2
var controls 						= {}
var configs 						= {}

# TODO: Keybind Mapping
# TODO: Audio Channel

func _ready():
	configs = {
		"sfx_volume" 				: sfx_volume 			as float,
		"music_volume" 				: music_volume 			as float,
		"screen_shake_level" 		: screen_shake_level 	as float,
		"controls" 					: controls 				as Dictionary
	}
	#delete_save()
	load_config()
	print(configs)

func load_config():
	if FileAccess.file_exists(SAVEFILE):
		var file 					= FileAccess.open(SAVEFILE, FileAccess.READ)
		var json_string := file.get_line()
		var loaded_configs
		
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			loaded_configs = json.data
		
		configs.sfx_volume 			= loaded_configs.sfx_volume
		configs.music_volume 		= loaded_configs.music_volume
		configs.screen_shake_level 	= loaded_configs.screen_shake_level
		configs.controls 			= loaded_configs.controls
		
		file = null
	else:
		configs.sfx_volume 			= 1.0
		configs.music_volume 		= 1.0
		configs.screen_shake_level 	= 1.0
		configs.controls 			= {
			"player1_up" 			: KEY_W,
			"player1_down" 			: KEY_S,
			"player1_pause" 		: KEY_ESCAPE,
			"player2_up" 			: KEY_UP,
			"player2_down" 			: KEY_DOWN,
			"player2_pause" 		: KEY_ENTER
		}
	bind_controls()
	
func save_config():
	var file 						= FileAccess.open(SAVEFILE, FileAccess.WRITE)
	json_string = JSON.stringify(configs)
	file.store_line(json_string)

func bind_controls() -> void:
	var key_event
	for control in controls:
		if controls[control] is InputEventKey:
			key_event 					= InputEventKey.new()
			key_event.keycode 			= controls[control].keycode
		if controls[control] is InputEventMouseButton:
			key_event = InputEventMouseButton.new()
			key_event.button_index = controls[control].button_index
		
		InputMap.action_erase_events(control)
		InputMap.action_add_event(control, key_event)

func delete_save():
	if FileAccess.file_exists(SAVEFILE):
		DirAccess.remove_absolute(SAVEFILE)
