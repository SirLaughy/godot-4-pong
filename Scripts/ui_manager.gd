extends Node

## UI Manager

var scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	open_menu(SignalBus.MenuType.MAIN_MENU) # open the main menu on start up


# instantiates the given menu and centers it in the appropriate location
func open_menu(menu : SignalBus.MenuType) -> void:
	var center : Vector2
	
	#close other open menus
	SignalBus.menu_closed.emit(menu)

	# initialise chosen menu
	match menu:
		SignalBus.MenuType.MAIN_MENU:
			scene = load("res://Scenes/main_menu.tscn")
			center = Vector2(576, 560)
	
	# instantiate menu
	var instance = scene.instantiate()
	add_child(instance)
	instance.position = center
	SignalBus.menu_opened.emit(menu)
