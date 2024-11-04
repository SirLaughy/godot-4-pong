extends CanvasLayer

# connect to the SceneManager signal for this scene
func _ready():
	GlobalSignals.scene_optionsMenu.connect(scene_optionsMenu)

# set sliders to global config values and show all required components
func scene_optionsMenu():
	$GridContainer/SFXSlider.value = GlobalConfigs.configs.sfx_volume
	$GridContainer/MusicSlider.value = GlobalConfigs.configs.music_volume
	$GridContainer/ScreenShakeSlider.value = GlobalConfigs.configs.screen_shake_level
	$"../GUIBackground".show()
	show()
	GlobalVariables.game_status = GlobalEnums.GameStatus.STOPPED

# When changes are applied set the config variables to the values of each slider, save the config file and return to previous scene
func _on_apply_changes_button_pressed():
	GlobalConfigs.configs.sfx_volume = $GridContainer/SFXSlider.value
	GlobalConfigs.configs.music_volume = $GridContainer/MusicSlider.value
	GlobalConfigs.configs.screen_shake_level = $GridContainer/ScreenShakeSlider.value
	GlobalConfigs.save_config()
	$"..".message("Settings Changed")
	hide()
	SceneManager.pop_stack()


# Return to previous scene
func _on_back_button_pressed():
	hide()
	SceneManager.pop_stack()

# Manage hiding external components when hidden
func _on_visibility_changed():
	if !is_visible():
		$"../GUIBackground".hide()

func _on_controls_pressed():
	hide()
	SceneManager.push_scene(GlobalEnums.GameScenes.CONTROLS_MENU)
