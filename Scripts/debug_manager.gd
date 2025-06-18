extends Node

## Debug Manager

var debug_array : Array = []

func _process(delta):
	$DebugLabel.text = str(debug_array)
