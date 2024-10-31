extends CanvasLayer

func _ready():
	GlobalSignals.scene_pauseMenu.connect(scene_pauseMenu)

func scene_pauseMenu():
	show()
	$"../Logo".show()
	$"../Message".show()
	$"../Message".text = "Paused"
	$"../GUIBackground".show()
	GlobalVariables.game_status = GlobalEnums.GameStatus.STOPPED


func _on_end_game_pressed():
	hide()
	SceneManager.set_stack(GlobalEnums.GameScenes.MAIN_MENU)


func _on_resume_game_pressed():
	hide()
	SceneManager.pop_stack()


func _on_options_button_pressed():
	hide()
	SceneManager.push_scene(GlobalEnums.GameScenes.OPTIONS_MENU)


func _on_visibility_changed():
	if !is_visible():
		$"../Logo".hide()
		$"../Message".hide()
		$"../GUIBackground".hide()
