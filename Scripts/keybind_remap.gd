extends Control

# Onready
@onready var label_up_p1 		= $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button_P1_Up/Label_Up_P1
@onready var label_down_p1 		= $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button_P1_Down/Label_Down_P1
@onready var label_pause_p1 	= $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button_P1_Pause/Label_Pause_P1
@onready var label_up_p2 		= $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button_P2_Up/Label_Up_P2
@onready var label_down_p2 		= $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button_P2_Down/Label_Down_P2
@onready var label_pause_p2 	= $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button_P2_Pause/Label_Pause_P2

# Initialise Empty Variables
var controls 		: Dictionary
var labels 			: Dictionary
var is_remapping 	: bool

var action_to_remap
var label_to_remap

# When called into scene tree connect to relevant Global Signals
func _ready():
	GlobalSignals.scene_controlsMenu.connect(scene_optionsMenu)
	GlobalSignals.controlMap_button_pressed.connect(on_controlMap_button_pressed)

# If we are actively remapping listen for input to bind to the corresponding action
func _input(event):
	if is_remapping:
		if event is InputEventKey || event is InputEventMouseButton:
			if event is InputEventKey:
				controls[action_to_remap] = event.keycode
			if event is InputEventMouseButton:
				if event.double_click:
					event.double_click = false
				controls[action_to_remap] = event.button_index
			
			label_to_remap.text = event.as_text()
			is_remapping 		= false
			
			accept_event()

# Initialise scene when loaded from Scene Manager
func scene_optionsMenu() -> void:
	controls 		= GlobalConfigs.configs.controls
	is_remapping 	= false
	configure_labels()
	show()

# Prepare to listen for input
func on_controlMap_button_pressed(label):
	is_remapping 	= true
	action_to_remap = labels[label]
	label_to_remap 	= label

# Bind controls to new config, save settings and return to last scene
func _on_button_confirm_pressed():
	GlobalConfigs.configs.controls = controls.duplicate()
	GlobalConfigs.bind_controls()
	GlobalConfigs.save_config()
	hide()
	SceneManager.pop_stack()
	SfxManager.play_sound(SfxManager.sfx_button_click)

# Return to last scene
func _on_button_back_pressed():
	hide()
	SceneManager.pop_stack()
	SfxManager.play_sound(SfxManager.sfx_button_click)

# Restore controls to default
func _on_button_restore_defaults_pressed():
	controls = GlobalConfigs.DEFAULT_CONTROLS
	configure_labels()
	SfxManager.play_sound(SfxManager.sfx_button_click)

# Set all button labels to the corresponding keybind
func configure_labels() -> void:
	labels = {
		label_up_p1 	: "player1_up",
		label_down_p1	: "player1_down",
		label_pause_p1 	: "player1_pause",
		label_up_p2 	: "player2_up",
		label_down_p2 	: "player2_down",
		label_pause_p2 	: "player2_pause"
	}

	for label in labels:
		var control = labels[label]
		set_label(label, controls[control])

# Set button label text to given value
func set_label(label : Object, value) -> void:
	var key_event
	if value > 10:
		key_event 				= InputEventKey.new()
		key_event.keycode 		= value
	else:
		key_event 				= InputEventMouseButton.new()
		key_event.button_index 	= value
	
	label.text = key_event.as_text()
