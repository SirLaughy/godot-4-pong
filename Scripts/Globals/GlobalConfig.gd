extends Node

class_name Global_Config

const SAVEFILE = "user://nimbusballconfig.save"

var sfx_volume : float
var music_volume : float
var screen_shake_level : float
var screen_size : Vector2
var controls = {
	
}

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
		controls = file.get_var(controls)
	else:
		sfx_volume = 1.0
		music_volume = 1.0
		screen_shake_level = 1.0
		controls = {
			"player1_up" 	: KEY_W,
			"player1_down" 	: KEY_S,
			"player1_pause" : KEY_ESCAPE,
			"player2_up" 	: KEY_UP,
			"player2_down" 	: KEY_DOWN,
			"player2_pause" : KEY_ENTER
		}
	bind_controls()
	
func save_config():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(sfx_volume)
	file.store_var(music_volume)
	file.store_var(screen_shake_level)
	file.store_var(controls)
	file = null

func bind_controls() -> void:
	var key_event
	for control in controls:
		InputMap.action_erase_events(control)
		key_event = InputEventKey.new()
		key_event.keycode = controls[control]
		InputMap.action_add_event(control, key_event)
