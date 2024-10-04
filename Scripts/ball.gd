extends CharacterBody2D

@export var initial_speed = 400

@onready var screen_size = get_viewport_rect().size
@onready var main = $".."

var speed = initial_speed
var acceleration = 10
var width = 32
var height = 32
var center = Vector2(width/2, height/2)
var direction = Vector2.RIGHT

func _process(delta):
	pass
		
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	var collider
	
	if collision:
		collider = collision.get_collider()
		if collider == $"../Player1" or collider == $"../Player2" or collider == $"../CPU":
			speed += acceleration
		direction = direction.bounce(collision.get_normal())
		

func random_direction():
	direction = Vector2([1, -1].pick_random(), randf_range(-1, 1))
	direction.normalized()
