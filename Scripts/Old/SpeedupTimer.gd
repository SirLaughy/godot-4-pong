extends Timer

func _ready():
	Engine.time_scale = 9000
	#pass



func _on_timeout():
	Engine.time_scale = 1
	GlobalSignals.speedup_finished.emit()
