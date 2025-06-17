extends Button

# disable focus mode on click
func _on_button_up():
	focus_mode = Control.FOCUS_NONE
