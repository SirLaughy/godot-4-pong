extends Node2D

## intantiates the game

# upon start speeds game up by x100 to initialise cloud positions
func _ready():
	Engine.time_scale = 100

# when EngineTimeTimer times out, initialise opening screen
func _on_timer_engine_time_timeout():
	Engine.time_scale = 1 # sets game speed back to default
	$EngineTimeTimer.queue_free() # removes the timer from memory
	
	# fade clouds in
	var tween = get_tree().create_tween()
	tween.tween_property($BackgroundSpriteTransition, "modulate", Color.TRANSPARENT, 10)
	tween.tween_callback($BackgroundSpriteTransition.queue_free)
