class_name ButtonScene
extends Button

## Base Button Class

# disable focus mode on click
func _on_button_up():
	focus_mode = Control.FOCUS_NONE
