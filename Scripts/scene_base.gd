extends Node2D

func _ready():
	Engine.time_scale = 100



func _on_timer_engine_time_timeout():
	Engine.time_scale = 1
	
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "modulate", Color.TRANSPARENT, 3)
	tween.tween_callback($ColorRect.queue_free)
