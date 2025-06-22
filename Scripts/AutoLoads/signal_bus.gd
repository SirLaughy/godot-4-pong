extends Node

signal menu_closed(menu)
signal menu_opened(menu)

signal selection_changed(selection_type, selection_index)

enum MenuType {
	MAIN_MENU,
}
