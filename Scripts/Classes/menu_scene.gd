class_name Menu
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.menu_closed.connect(_on_menu_closed)


# when menu closed delete self from menu
func _on_menu_closed():
	queue_free()
