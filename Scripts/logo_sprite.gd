extends Sprite2D

func _ready():
	SignalBus.menu_closed.connect(_on_menu_closed)

func _on_menu_closed():
	visible = false
