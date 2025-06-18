extends Node

signal menu_closed(menu)
signal menu_opened(menu)

signal selection_changed(setting, selection)

enum MenuType {
	MAIN_MENU,
}
