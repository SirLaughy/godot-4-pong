extends CanvasLayer

func _ready():
	GlobalSignals.scene_pauseMenu.connect(scene_pauseMenu)

func scene_pauseMenu():
	show()
	$"../Logo".show()
	%Message.show()
	%Message.text = "Paused"
	GlobalVariables.game_status = GlobalEnums.GameStatus.STOPPED


func _on_end_game_pressed():
	hide()
	SceneManager.set_stack(GlobalEnums.GameScenes.MAIN_MENU)
	SfxManager.play_sound(SfxManager.sfx_game_over)
	SfxManager.play_sound(SfxManager.sfx_button_click)

func _on_resume_game_pressed():
	hide()
	pause_timer()
	SfxManager.play_sound(SfxManager.sfx_button_click)


func _on_options_button_pressed():
	hide()
	SceneManager.push_scene(GlobalEnums.GameScenes.OPTIONS_MENU)
	SfxManager.play_sound(SfxManager.sfx_button_click)


func _on_visibility_changed():
	if !is_visible():
		$"../Logo".hide()
		%Message.hide()

func pause_timer():
	var seconds = 3
	%Message.show()
	while seconds > 0:
		%Message.text = str(seconds)
		await get_tree().create_timer(1).timeout
		seconds -= 1
	$"..".message("Resumed")
	SceneManager.pop_stack()
	
