class_name Cloud_Type
extends Resource

# Cloud Properties for use with the Cloud Spawner

@export var name : String # Cloud Type Name
@export var sprite_sheet : Texture2D # Spritesheet for use
@export var rows : int # Amount of Sprites per row in the spritesheet to calculate sprite width
@export var columns : int # Amount of Sprites per column in the spritesheet to claculate sprite height
@export_range(1, 9) var cloud_size : int # Size of cloud from 1-9 to impact the movement speed of the cloud 
