extends Node

# Scene Manager
signal scene_mainMenu
signal scene_gameScene
signal scene_pauseMenu
signal scene_optionsMenu
signal scene_controlsMenu

# Game Control
signal New_Game
signal point_scored(side)
signal paddle_collision(collision)
signal cloud_collision(collision)

# Options Control
signal controlMap_button_pressed(label)

