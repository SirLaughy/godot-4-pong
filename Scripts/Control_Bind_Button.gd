extends Button

const BIND_TEXT = "Press Key to Bind" as String

func _ready():
	pressed.connect(on_button_press)

func on_button_press():
	get_child(0).text = BIND_TEXT
	GlobalSignals.controlMap_button_pressed.emit(get_child(0))
