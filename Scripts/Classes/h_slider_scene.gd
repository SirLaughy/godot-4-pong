class_name VSliderScene
extends HBoxContainer

enum SliderType {
	BUS,
	SOUND,
	VARIABLE,
}

@export_group("Label")
@export var slider_name : String
@export_group("Slider")
@export var min_value : int = 0
@export var max_value : int = 100
@export var step : int = 1
@export var value : int = 100

@onready var label := $Label
@onready var h_slider := $HSlider


func _ready():
	SignalBus.selection_changed.connect(_on_selection_changed)
	init_slider()

func _on_selection_changed(selection_type, selection_index) -> void:
	pass

func init_slider() -> void:
	# Label
	label.text = str(slider_name)
	
	# HSlider
	h_slider.min_value = min_value
	h_slider.max_value = max_value
	h_slider.step = step
	h_slider.value = value
