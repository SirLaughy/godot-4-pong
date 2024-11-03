extends Control

@onready var label_up_p1 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button_P1_Up/Label_Up_P1
@onready var label_down_p1 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button_P1_Down/Label_Down_P1
@onready var label_pause_p1 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Button_P1_Pause/Label_Pause_P1
@onready var label_up_p2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button_P2_Up/Label_Up_P2
@onready var label_down_p2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button_P2_Down/Label_Down_P2
@onready var label_pause_p2 = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Button_P2_Pause/Label_Pause_P2

var controls : Dictionary
var labels : Dictionary
var is_remapping : bool
var action_to_remap
var label_to_remap


func _ready():
	GlobalSignals.scene_controlsMenu.connect(scene_optionsMenu)
	GlobalSignals.controlMap_button_pressed.connect(on_controlMap_button_pressed)

func _input(event):
	if is_remapping:
		if event is InputEventKey || event is InputEventMouseButton:
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false

			label_to_remap.text = event.as_text()
			controls[action_to_remap] = event
			is_remapping = false
			
			accept_event()
			
			print(str(event))

func scene_optionsMenu() -> void:
	controls = GlobalConfigs.configs.controls.duplicate()
	is_remapping = false
	configure_labels()
	show()

func set_label(label : Object, value) -> void:
	var key_event 				= InputEventKey.new()
	key_event.keycode 			= value
	
	label.text = key_event.as_text()

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

func on_controlMap_button_pressed(label):
	is_remapping = true
	action_to_remap = labels[label]
	label_to_remap = label
	print(str(action_to_remap))


func _on_button_confirm_pressed():
	GlobalConfigs.controls = controls.duplicate()
	GlobalConfigs.bind_controls()
	GlobalConfigs.save_config()
	hide()
	SceneManager.pop_stack()


func _on_button_back_pressed():
	hide()
	SceneManager.pop_stack()
