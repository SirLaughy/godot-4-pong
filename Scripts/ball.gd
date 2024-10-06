extends CharacterBody2D

@export var initial_speed = 600

@onready var main = get_parent()
@onready var screen_size = get_viewport_rect().size

const MAX_Y_VECTOR = 0.6

var speed = initial_speed
var acceleration = 15
var width = 64
var height = 64
var center = Vector2(round(width/2), round(height/2))
var direction = Vector2.RIGHT
var initial_rotation_speed = 0.01
var rotation_speed = initial_rotation_speed

func _physics_process(delta):
	if main.game_status == Global.GameStatus.IN_PROGRESS:
	
		var collision = move_and_collide(direction * speed * delta)
		if direction.x < 0:
			rotation -= rotation_speed
		if direction.x > 0:
			rotation += rotation_speed
		var collider
		
		if collision:
			collider = collision.get_collider()
			if (collider == $"../Player1" or collider == $"../Player2" or collider == $"../CPU") and is_front(collision):
				speed += acceleration
				rotation_speed += initial_rotation_speed
				direction = new_direction(collider)
			else:
				direction = direction.bounce(collision.get_normal())
		

func random_direction():
	direction = Vector2([1, -1].pick_random(), randf_range(-1, 1))
	direction.normalized()

func new_direction(collider):
	var distance = position.y - collider.position.y
	var new_direction := Vector2()
	
	if direction.x > 0:
		new_direction.x = -1
	else:
		new_direction.x = 1
	new_direction.y = (distance / collider.center.y) * MAX_Y_VECTOR
	return new_direction.normalized()
	
func is_front(collision):
	return not collision.get_normal().y == -1 or collision.get_normal().y == 1

