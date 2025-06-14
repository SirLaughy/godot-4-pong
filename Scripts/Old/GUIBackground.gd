extends ColorRect

var offset = 60

func _ready():
	size.x = GlobalConfigs.screen_size.x - offset
	size.y = GlobalConfigs.screen_size.y - offset
