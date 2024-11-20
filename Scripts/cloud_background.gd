extends Node2D

@export var time_scale : int

@onready var cloud_long = $CloudLong
@onready var cloud_small = $CloudSmall
@onready var cloud_medium = $CloudMedium
@onready var cloud_big = $CloudBig

var clouds : Array

func _ready():
	clouds = [cloud_long, cloud_small, cloud_medium, cloud_big]
	for cloud in clouds:
		cloud.speed_scale = 1 * time_scale
		cloud.on_timer.wait_time = cloud.on_time / time_scale
		cloud.off_timer.wait_time = cloud.off_time / time_scale

func _on_opening_timer_timeout():
	for cloud in clouds:
		var tween = get_tree().create_tween()
		tween.tween_property(cloud, "speed_scale", 1, 5)
		tween.parallel().tween_property(cloud.on_timer, "wait_time", cloud.on_time, 5)
		tween.parallel().tween_property(cloud.off_timer, "wait_time", cloud.off_time, 5)

