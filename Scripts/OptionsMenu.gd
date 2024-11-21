extends CanvasLayer

@onready var sfx_slider = %SFXSlider
@onready var music_slider = %MusicSlider
@onready var audio_channel_menu = %AudioChannelMenu
@onready var check_box_show_controls = %CheckBoxShowControls
@onready var screen_shake_slider = %ScreenShakeSlider

var output_devices : Array


# connect to the SceneManager signal for this scene
func _ready():
	GlobalSignals.scene_optionsMenu.connect(scene_optionsMenu)
	audio_channel_menu.get_popup().id_pressed.connect(on_output_device_pressed)
	output_devices = AudioServer.get_output_device_list()

# set sliders to global config values and show all required components
func scene_optionsMenu():
	sfx_slider.value = GlobalConfigs.configs.sfx_volume
	music_slider.value = GlobalConfigs.configs.music_volume
	screen_shake_slider.value = GlobalConfigs.configs.screen_shake_level
	check_box_show_controls.set_pressed(GlobalConfigs.configs.show_controls)
	initialise_audio_channel_menu()
	show()
	GlobalVariables.game_status = GlobalEnums.GameStatus.STOPPED

# When changes are applied set the config variables to the values of each slider, save the config file and return to previous scene
func _on_apply_changes_button_pressed():
	# Sound
	GlobalConfigs.configs.sfx_volume = sfx_slider.value
	GlobalConfigs.configs.music_volume = music_slider.value
	GlobalConfigs.set_bus_volume("SFX", GlobalConfigs.configs.sfx_volume)
	GlobalConfigs.set_bus_volume("Music", GlobalConfigs.configs.music_volume)
	GlobalConfigs.configs.output_device = audio_channel_menu.text
	AudioServer.set_output_device(GlobalConfigs.configs.output_device)
	
	# Controls
	GlobalConfigs.configs.show_controls = check_box_show_controls.is_pressed()

	# Accessibility
	GlobalConfigs.configs.screen_shake_level = screen_shake_slider.value
	
	# Save and Return to Previous Scene
	GlobalConfigs.save_config()
	$"..".message("Settings Changed")
	hide()
	SceneManager.pop_stack()
	SfxManager.play_sound(SfxManager.sfx_button_click)

# Return to previous scene
func _on_back_button_pressed():
	hide()
	SceneManager.pop_stack()
	SfxManager.play_sound(SfxManager.sfx_button_click)

func _on_controls_pressed():
	hide()
	SceneManager.push_scene(GlobalEnums.GameScenes.CONTROLS_MENU)
	SfxManager.play_sound(SfxManager.sfx_button_click)

func initialise_audio_channel_menu() -> void:
	var id = 0
	audio_channel_menu.text = GlobalConfigs.configs.output_device
	for output_device in output_devices:
		audio_channel_menu.get_popup().add_item(output_device, id)
		id += 1

func on_output_device_pressed(id : int) -> void:
	audio_channel_menu.text = output_devices[id]
