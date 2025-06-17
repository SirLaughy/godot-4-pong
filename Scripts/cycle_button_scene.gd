extends Control

## Base cycle button scene

signal selection_changed(type, selection)

@export var cycle_name : String
@export var text_array : Array

# when current_selection is changed update the selection text and emit signal
var current_selection : int:
	get:
		return current_selection 
	set(value):
		current_selection = value
		selection_label.text = str(text_array[value])
		selection_changed.emit(cycle_name, text_array[value])

@onready var cycle_label = $VBoxContainer/CycleLabel
@onready var up_button = $VBoxContainer/UpButton
@onready var selection_label = $VBoxContainer/SelectionLabel
@onready var down_button = $VBoxContainer/DownButton


# Called when the node enters the scene tree for the first time.
func _ready():
	# set defaults
	current_selection = 0 # set selection to default
	cycle_label.text = str(cycle_name) # set initial label


func _on_up_button_button_up():
	# go to next option in array, snakes
	if current_selection != text_array.size() - 1: 
		current_selection += 1
	else:
		current_selection = 0


func _on_down_button_button_up():
	# go to previous option in array, snakes
	if current_selection != 0:
		current_selection -= 1
	else:
		current_selection = text_array.size() - 1
