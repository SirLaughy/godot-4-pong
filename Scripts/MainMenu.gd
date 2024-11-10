extends CanvasLayer

func _ready():
	GlobalSignals.scene_mainMenu.connect(scene_mainMenu)
	
func scene_mainMenu():
	show()
	$"../Logo".show()
	$"../Scores".show()
	$"New Game".show()
	GlobalVariables.game_status = GlobalEnums.GameStatus.STOPPED

func _on_visibility_changed():
	if !is_visible():
		$"../Logo".hide()
		$"../Message".hide()
		$"../Scores".hide()
		$GameMode.hide()

func _on_new_game_pressed():
	$"New Game".hide()
	$GameMode.show()
	SfxManager.play_sound(SfxManager.sfx_button_click)

func _on_quit_pressed():
	SfxManager.play_sound(SfxManager.sfx_button_click)
	await SfxManager.sfx_button_click.finished
	get_tree().quit()
	

func _on_options_button_pressed():
	hide()
	SceneManager.push_scene(GlobalEnums.GameScenes.OPTIONS_MENU)
	SfxManager.play_sound(SfxManager.sfx_button_click)

func _on_singleplayer_pressed():
	GlobalVariables.game_mode = GlobalEnums.GameMode.SINGLEPLAYER
	start_game()
	SfxManager.play_sound(SfxManager.sfx_button_click)

func _on_multiplayer_pressed():
	GlobalVariables.game_mode = GlobalEnums.GameMode.MULTIPLAYER
	start_game()
	SfxManager.play_sound(SfxManager.sfx_button_click)
	
func start_game():
	hide()
	GlobalVariables.game_status = GlobalEnums.GameStatus.RUNNING
	SceneManager.set_stack(GlobalEnums.GameScenes.GAME_SCENE)
	GlobalSignals.New_Game.emit()
	SfxManager.play_sound(SfxManager.sfx_button_click)
