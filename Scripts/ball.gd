extends CharacterBody2D

# signals
signal cpu_collision

# export
@export var initial_speed = 600

#  onready
@onready var main = get_parent()

# consts
const MAX_Y_VECTOR = 0.6

# variable declarations
var speed = initial_speed
var acceleration = 15
var direction = Vector2.RIGHT
var initial_rotation_speed = 0.01
var rotation_speed = initial_rotation_speed

var width = 64
var height = 64
var center = Vector2(round(width/2), round(height/2))


func _physics_process(delta):
	# check that game is in progress
	if GlobalVariables.game_status == GlobalEnums.GameStatus.RUNNING:
	
		# move in a straight direction and check for collisions
		var collision = move_and_collide(direction * speed * delta)
		if direction.x < 0:
			rotation -= rotation_speed
		if direction.x > 0:
			rotation += rotation_speed
		var collider
		
		# if collision bounce
		if collision:
			collider = collision.get_collider()
			# if collision with player increase acceleration and rotation speed as well as changing angle of bounce depending on the part of the paddle it collides with
			if (collider == $"../Player1" or collider == $"../Player2" or collider == $"../CPU") and is_front(collision):
				speed += acceleration
				rotation_speed += initial_rotation_speed
				direction = find_new_direction(collider)
				# default trauma 0.2
				$"../ShakeCamera".add_trauma(0.2)
				if collider == $"../CPU":
					cpu_collision.emit()
			else:
				direction = direction.bounce(collision.get_normal())
		

# get a random direction
func random_direction():
	direction = Vector2([1, -1].pick_random(), randf_range(-1, 1))
	direction.normalized()

# get the new direction of the ball according to the bounce
func find_new_direction(collider):
	var distance = position.y - collider.position.y
	var new_direction := Vector2()
	
	if direction.x > 0:
		new_direction.x = -1
	else:
		new_direction.x = 1
	new_direction.y = (distance / collider.center.y) * MAX_Y_VECTOR
	return new_direction.normalized()

# check that the ball is colliding with the front of the paddle	
func is_front(collision):
	return not collision.get_normal().y == -1 or collision.get_normal().y == 1

