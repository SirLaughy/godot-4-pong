extends Area2D

## spawns clouds to scroll across the background

var scene : PackedScene

@export var clouds_on_start : int
@export var spawns_per_timer : int

@onready var spawn_area = $SpawnArea
@onready var init_spawn_area = $CloudInit/SpawnArea


# loads cloud scene into memory
func _ready():
	scene = load("res://Scenes/cloud_scene.tscn") # load cloud object into memory
	spawn_cloud(clouds_on_start, init_spawn_area) # spawn initial clouds around the screen
	$CloudInit.queue_free() # remove uneeded nodes from memory


# when SpawnTimer times out spawn clouds
func _on_timer_timeout():
	spawn_cloud(spawns_per_timer, spawn_area)


# spawn an amount of clouds in a given area
func spawn_cloud(number_to_spawn : int, area : Object) -> void:
	for n in number_to_spawn:
		# create a cloud
		var cloud = scene.instantiate()
		add_child(cloud)
		
		# set clouds position to a random place within the given area
		cloud.position.y = cloud.rng.randi_range(area.position.y - area.shape.size.y, area.position.y + area.shape.size.y)
		cloud.position.x = cloud.rng.randi_range(area.position.x - area.shape.size.x, area.position.x + area.shape.size.x)
