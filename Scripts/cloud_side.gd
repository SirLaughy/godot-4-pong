extends Node2D

@onready var cloud_generator = $cloud_generator
@onready var on_timer = $On_Timer
@onready var off_timer = $Off_Timer

@export var time_scale : int

const DEFAULT_ON_TIMER = 1
const DEFAULT_OFF_TIMER = 10
const DEFAULT_SPEED_SCALE = 1

func _ready():
	on_timer.wait_time = DEFAULT_ON_TIMER / time_scale
	off_timer.wait_time = DEFAULT_OFF_TIMER / time_scale
	cloud_generator.speed_scale = DEFAULT_SPEED_SCALE * time_scale
	on_timer.start()
	cloud_generator.emitting = true

func _on_on_timer_timeout():
	cloud_generator.emitting = false
	off_timer.start()

func _on_off_timer_timeout():
	cloud_generator.emitting = true
	on_timer.start()

func _on_opening_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(cloud_generator, "speed_scale", DEFAULT_SPEED_SCALE, 5)
	tween.parallel().tween_property(on_timer, "wait_time", DEFAULT_ON_TIMER, 5)
	tween.parallel().tween_property(off_timer, "wait_time", DEFAULT_OFF_TIMER, 5)
	#cloud_generator.speed_scale = DEFAULT_SPEED_SCALE
	off_timer.stop()
	on_timer.start()
