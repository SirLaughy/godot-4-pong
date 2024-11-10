extends Node2D

@onready var dust = $Dust


func _ready():
	connect_signals()

func connect_signals():
	GlobalSignals.cloud_collision.connect(on_cloud_collision)
	GlobalSignals.paddle_collision.connect(on_paddle_collision)

func on_cloud_collision(collision):
	pass

func on_paddle_collision(collision):
	dust.position = collision.get_position()
	dust.rotation = get_angle_to(collision.get_normal())
	dust.emitting = true
