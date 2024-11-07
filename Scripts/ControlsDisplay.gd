extends CanvasLayer

func _ready():
	GlobalSignals.scene_gameScene.connect(on_scene_gameScene)

func on_scene_gameScene():
	show()
