extends Node



var current_scene : GlobalEnums.GameScenes
var scene_stack : = []

func _ready():
	current_scene = GlobalEnums.GameScenes.MAIN_MENU
	scene_stack = [current_scene]

# Handle the actual scene change according to the current scene
func set_scene():
	current_scene = scene_stack.front()
	match current_scene:
		GlobalEnums.GameScenes.MAIN_MENU:
			GlobalSignals.scene_mainMenu.emit()
		GlobalEnums.GameScenes.GAME_SCENE:
			GlobalSignals.scene_gameScene.emit()
		GlobalEnums.GameScenes.PAUSE_MENU:
			GlobalSignals.scene_pauseMenu.emit()
		GlobalEnums.GameScenes.OPTIONS_MENU:
			GlobalSignals.scene_optionsMenu.emit()

# Add new scene to stack changing the current scene
func push_scene(scene):
	scene_stack.insert(0, scene)
	set_scene()

# Reset the stack
func set_stack(scene):
	scene_stack = [scene]
	set_scene()

# Return to previous scene in the stack
func pop_stack():
	scene_stack.remove_at(0)
	set_scene()
