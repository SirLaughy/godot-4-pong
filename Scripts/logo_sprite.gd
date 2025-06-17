extends Sprite2D

func _ready():
	SignalBus.menu_closed.connect(_on_menu_closed)
	SignalBus.menu_opened.connect(_on_menu_opened)

func _on_menu_opened(menu) -> void:
	match menu:
		SignalBus.MenuType.MAIN_MENU:
			visible = true

func _on_menu_closed(menu):
	visible = false
