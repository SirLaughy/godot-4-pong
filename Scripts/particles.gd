extends Node2D

var dust = preload("res://Scenes/dust.tscn")
var cloud = preload("res://Scenes/cloud.tscn")


func _ready():
	connect_signals()

func connect_signals():
	GlobalSignals.cloud_collision.connect(on_cloud_collision)
	GlobalSignals.paddle_collision.connect(on_paddle_collision)

func on_cloud_collision(collision):
	var instance = cloud.instantiate()
	instance.position = collision.get_position()
	instance.rotation = get_angle_to(collision.get_normal())
	instance.emitting = true
	add_child(instance)

func on_paddle_collision(collision):
	var instance = dust.instantiate()
	instance.position = collision.get_position()
	instance.rotation = get_angle_to(collision.get_normal())
	instance.emitting = true
	add_child(instance)
