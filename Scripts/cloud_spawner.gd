extends Area2D

## spawns clouds on a timer

@onready var spawn_area = $SpawnArea

var scene : PackedScene

# loads cloud scene into memory
func _ready():
	scene = load("res://Scenes/cloud.tscn")

# spawn cloud with random y within spawner body
func _on_timer_timeout():
	var cloud = scene.instantiate()
	add_child(cloud)
	cloud.position.y = cloud.rng.randi_range(spawn_area.position.y - spawn_area.shape.size.y, spawn_area.position.y + spawn_area.shape.size.y)
	cloud.position.x = spawn_area.position.x + spawn_area.shape.size.x
