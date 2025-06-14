extends Control

# declare variables
@export var side : GlobalEnums.PaddleSide

@onready var event_moveUp = $GridContainer/Move_Up_Event
@onready var event_moveDown = $GridContainer/Move_Down_Event
@onready var event_pause = $GridContainer/Pause_Event


var controls : Dictionary

func _ready():
	GlobalSignals.New_Game.connect(on_newGame)
	GlobalSignals.scene_gameScene.connect(on_scene_gameScene)
	GlobalSignals.scene_optionsMenu.connect(on_scene_optionsMenu)
	set_text()

func on_scene_gameScene():
	if GlobalConfigs.configs.show_controls:
		match GlobalVariables.game_mode:
			GlobalEnums.GameMode.SINGLEPLAYER:
				if side == GlobalEnums.PaddleSide.RIGHT:
					hide()
			GlobalEnums.GameMode.MULTIPLAYER:
				show()
	else:
		hide()

func on_scene_optionsMenu():
	set_text()

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
	if visible:
		$Transition_Timer.start()
		scale = Vector2(0.5, 0.5)
		position.y = 194
		modulate.a = 1
		match side:
			GlobalEnums.PaddleSide.LEFT:
				position.x = 128
			GlobalEnums.PaddleSide.RIGHT:
				position.x = 800

func get_x():
	match side:
		GlobalEnums.PaddleSide.LEFT:
			return 40
		GlobalEnums.PaddleSide.RIGHT:
			return 1038

func _on_transition_timer_timeout():
	if visible:
		var tween = get_tree().create_tween()
		tween.tween_property($".", "scale", Vector2(0.2, 0.2), 0.5)
		tween.parallel().tween_property($".", "position", Vector2(get_x(), 500), 0.5)
		tween.parallel().tween_property($".", "modulate:a", 0.5, 0.5)

