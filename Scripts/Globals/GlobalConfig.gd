extends Node

class_name Global_Config

# declare constants
const SAVEFILE 						= "user://nimbusballconfig.json"
const DEFAULT_SFX_VOLUME			= 1.0
const DEFAULT_MUSIC_VOLUME			= 1.0
const DEFAULT_OUTPUT_DEVICE			= "Default"
const DEFAULT_SCREEN_SHAKE_LEVEL	= 1.0
const DEFAULT_SHOW_CONTROLS			= true

const DEFAULT_CONTROLS = {
	"player1_up" 					: KEY_W,
	"player1_down" 					: KEY_S,
	"player1_pause" 				: KEY_ESCAPE,
	"player2_up" 					: KEY_UP,
	"player2_down" 					: KEY_DOWN,
	"player2_pause" 				: KEY_ENTER
}

# declare empty variables
var sfx_volume 						: float
var music_volume 					: float
var output_device					: String
var screen_shake_level 				: float
var screen_size 					: Vector2
var controls 						: Dictionary
var show_controls					: bool
var configs 						: Dictionary

var json_string

# TODO:|| Audio Channel

# Initialise config dictionary and load from file if possible
func _ready():
	configs = {
		"sfx_volume" 				: sfx_volume, 
		"music_volume" 				: music_volume,
		"output_device"				: output_device,
		"screen_shake_level" 		: screen_shake_level,
		"controls" 					: controls,
		"show_controls"				: show_controls
	}
	load_config()
	bind_controls()
	set_bus_volume("SFX", configs.sfx_volume)
	set_bus_volume("Music", configs.music_volume)
	AudioServer.set_output_device(configs.output_device)

# load configs from save, if not avaliable load defaults
func load_config():
	if FileAccess.file_exists(SAVEFILE):
		var file 			= FileAccess.open(SAVEFILE, FileAccess.READ)
		json_string 		= file.get_line()
		var loaded_configs
		
		# convert json string into dictionary
		var json 	= JSON.new()
		var error 	= json.parse(json_string)
		if error == OK:
			loaded_configs = json.data
		
		configs.sfx_volume 			= loaded_configs.sfx_volume
		configs.music_volume 		= loaded_configs.music_volume
		configs.output_device		= loaded_configs.output_device
		configs.screen_shake_level 	= loaded_configs.screen_shake_level
		configs.controls 			= loaded_configs.controls
		configs.show_controls		= loaded_configs.show_controls
	# load defaults
	else:
		configs.sfx_volume 			= DEFAULT_SFX_VOLUME
		configs.music_volume 		= DEFAULT_MUSIC_VOLUME
		configs.output_device		= DEFAULT_OUTPUT_DEVICE
		configs.screen_shake_level 	= DEFAULT_SCREEN_SHAKE_LEVEL
		configs.controls 			= DEFAULT_CONTROLS
		configs.show_controls		= DEFAULT_SHOW_CONTROLS

# save current configs to file
func save_config():
	var file 		= FileAccess.open(SAVEFILE, FileAccess.WRITE)
	json_string 	= JSON.stringify(configs)
	file.store_line(json_string)

# bind the keys found in controls to InputMap
func bind_controls() -> void:
	var key_event
	for control in configs.controls:
		# if less than 10 it's probably a mouse button
		if configs.controls[control] > 10:
			key_event 				= InputEventKey.new()
			key_event.keycode 		= configs.controls[control]
		else:
			key_event 				= InputEventMouseButton.new()
			key_event.button_index 	= configs.controls[control]
		
		InputMap.action_erase_events(control)
		InputMap.action_add_event(control, key_event)

func set_bus_volume(bus, value):
	var bus_index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
