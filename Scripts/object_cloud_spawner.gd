extends Area2D

@onready var cloud_spawner_collision = $cloud_spawner_collision

var scene

func _ready():
	scene = load("res://Scenes/object_cloud.tscn")

func _on_timer_timeout():
	var cloud = scene.instantiate()
	add_child(cloud)
	cloud.position.y = cloud.rng.randi_range(cloud_spawner_collision.position.y - cloud_spawner_collision.shape.size.y, cloud_spawner_collision.position.y + cloud_spawner_collision.shape.size.y)
	cloud.position.x = cloud_spawner_collision.position.x + cloud_spawner_collision.shape.size.x
