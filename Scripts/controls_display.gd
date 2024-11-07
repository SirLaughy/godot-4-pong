extends Control

# declare variables
@export var side : GlobalEnums.PaddleSide

@onready var event_moveUp = $Move_Up/Event
@onready var event_moveDown = $Move_Down/Event
@onready var event_pause = $Pause/Event


var controls : Dictionary

func _ready():
	GlobalSignals.New_Game.connect(on_newGame)
	GlobalSignals.scene_gameScene.connect(on_scene_gameScene)

func on_scene_gameScene():
	set_text()
	match GlobalVariables.game_mode:
		GlobalEnums.GameMode.SINGLEPLAYER:
			if side == GlobalEnums.PaddleSide.RIGHT:
				hide()
		GlobalEnums.GameMode.MULTIPLAYER:
			pass

func on_newGame():
	transition()

func set_text():
	controls = GlobalConfigs.configs.controls
	match side:
		GlobalEnums.PaddleSide.LEFT:
			event_moveUp.text = get_text(controls.player1_up)
			event_moveDown.text = get_text(controls.player1_down)
			event_pause.text = get_text(controls.player1_pause)
		GlobalEnums.PaddleSide.RIGHT:
			event_moveUp.text = get_text(controls.player2_up)
			event_moveDown.text = get_text(controls.player2_down)
			event_pause.text = get_text(controls.player2_pause)

func get_text(event : int) -> String:
	var temp
	if event > 10: #keycode
		temp = InputEventKey.new()
		temp.keycode = event
		return temp.as_text()
	else: #mousebutton
		temp = InputEventMouseButton.new()
		temp.button_index = event
		if temp.button_index == 1:
			return "LMB"
		if temp.button_index == 2:
			return "RMB"
		if temp.button_index == 3:
			return "MMB"
		else:
			return temp.as_text() 
		
func transition():
	$Transition_Timer.start()
	scale = Vector2(0.5, 0.5)
	position.y = 194
	if visible:
		modulate.a = 1
	match side:
		GlobalEnums.PaddleSide.LEFT:
			position.x = 128
		GlobalEnums.PaddleSide.RIGHT:
			position.x = 800

func get_x():
	match side:
		GlobalEnums.PaddleSide.LEFT:
			return 16
		GlobalEnums.PaddleSide.RIGHT:
			return 1038

func _on_transition_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(0.2, 0.2), 0.5)
	tween.parallel().tween_property($".", "position", Vector2(get_x(), 526), 0.5)
	if visible:
		tween.parallel().tween_property($".", "modulate:a", 0.5, 0.5)

