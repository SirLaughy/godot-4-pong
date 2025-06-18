class_name Menu
extends Control

## Base Menu Class

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect to signals
	SignalBus.menu_closed.connect(_on_menu_closed)


# when menu closed delete self from menu
func _on_menu_closed():
	queue_free()
