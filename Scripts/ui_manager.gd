extends Node

enum MenuType {
	MAIN_MENU,
}

var scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	open_menu(MenuType.MAIN_MENU) # open the main menu on start up


# instantiates the given menu and centers it in the appropriate location
func open_menu(menu : MenuType) -> void:
	var center : Vector2
	var logo : bool
	
	SignalBus.menu_closed.emit()
	# initialise chosen menu
	match menu:
		MenuType.MAIN_MENU:
			scene = load("res://Scenes/main_menu.tscn")
			center = Vector2(576, 524)
			logo = true
	
	# instantiate menu
	# TODO find out why logo isn't showing and why control is spread out when instantiated
	var instance = scene.instantiate()
	add_child(instance)
	instance.position = center
	$LogoSprite.visible = logo
