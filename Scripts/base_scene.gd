extends Node

## General Manager

var configs : Dictionary = {
	"Players" : 0, # index 0 (1)
	"First To" : 1, #index 1 (5)
}

# connect to signals
func _enter_tree():
	SignalBus.selection_changed.connect(_on_selection_changed)
	SignalBus.menu_opened.connect(_on_menu_opened)

# Called when the node enters the scene tree for the first time.
func _ready():
	debug_set_up()

# track selection variables
func _on_selection_changed(setting, selection) -> void:
	configs[setting] = selection

# set menu defaults
func _on_menu_opened(menu) -> void:
	match menu:
		SignalBus.MenuType.MAIN_MENU:
			# set the cycle buttons to the last selected or default
			%UIManager/MainMenu/MarginContainer/VBoxContainer/HBoxContainer/PlayersCycleButton.current_selection = configs["Players"]
			%UIManager/MainMenu/MarginContainer/VBoxContainer/HBoxContainer/FirstToCycleButton.current_selection = configs["First To"]

# set up debug functions
func debug_set_up() -> void:
	%DebugManager.debug_array.append(configs) # add config variables to the debug label
