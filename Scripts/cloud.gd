extends StaticBody2D

## Initialise and move clouds across the screen

@export var cloud_type : Resource
@export var wind_speed : int
@export var cloud_type_weights : Dictionary

@onready var cloud_sprite = $CloudSprite

var speed : int
var rng : RandomNumberGenerator


func _ready():
	rng = RandomNumberGenerator.new() # establish the seed for the Random Number Generator
	cloud_init() # initialise cloud properties (resource, sprite, scale, rotation and transparency)


func _process(delta):
	position.x -= speed * delta # move left 
	position.y -= speed * 0.1 * delta # move upwards slowly

	# if cloud is off screen, delete
	if position.x < -1000.0 - (float(cloud_type.sprite_sheet.get_width()) / float(cloud_type.columns * scale.x)) or position.y < -1000.0 - (float(cloud_type.sprite_sheet.get_height()) / float(cloud_type.rows * scale.y)):
		queue_free()


func cloud_init() -> void:
	# generate random stats
	cloud_type = rand_weight(cloud_type_weights) # randomise cloud_type resource
	speed = ((((100.0 - (float(cloud_type.cloud_size) * 5.0)) / 100.0) * float(wind_speed)) * rng.randf_range(0.9, 1.1)) # randomise speed based on cloud size
	scale = Vector2(rng.randf_range(0.8, 1.2), rng.randf_range(0.8, 1.2)) # randomise scale
	rotate(rng.randi_range(-6, 6)) # randomise rotation
	modulate.a = rng.randf_range(0.1, 0.4) # randomise transparency
	
	# initialise sprite
	cloud_sprite.texture = cloud_type.sprite_sheet # set sprite sheet
	cloud_sprite.hframes = cloud_type.columns # set amount of horizontal frames in spritesheet
	cloud_sprite.vframes = cloud_type.rows # set amount of vertical frames in spritesheet
	cloud_sprite.frame = rng.randi_range(0, (cloud_type.columns * cloud_type.rows) - 1) # randomly choose sprite in spritesheet

func rand_weight(weight_dict : Dictionary) -> Object:
	var total : int # sum of weights
	var random : int # random number betweeen 1 and total
	var sorting_array : Array # temp array to get weights in descending order
	
	# sort weights by descending order
	sorting_array = weight_dict.values()
	sorting_array.sort()
	sorting_array.reverse()
	
	# iterate through sorting array to calculate total
	for weight in sorting_array:
		total += weight
	
	# generate random number
	random = rng.randi_range(1, total - 1)
	
	# iterate through sorting array to determine chosen result
	for weight in sorting_array:
		# if the random number is less than the given weight, then the random number is associated with that weight
		if random < weight:
			return weight_dict.find_key(weight)
		# if it's not, subtract the weight from the random number and go to the next weight
		else:
			random -= weight
	print("Weighting not Succesful")
	return null
