extends Button

# Define Constants
const BIND_TEXT = "Press Key to Bind" as String

# Connect to button press signal
func _ready():
	pressed.connect(on_button_press)

# Change Label to listening text and signal to main control script to listen for input
func on_button_press():
	get_child(0).text = BIND_TEXT
	GlobalSignals.controlMap_button_pressed.emit(get_child(0))
