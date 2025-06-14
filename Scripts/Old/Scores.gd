extends CanvasGroup

@onready var score_1 = $Score1
@onready var score_2 = $Score2

func _ready():
	GlobalSignals.point_scored.connect(on_point_scored)

func on_point_scored(side):
	var paddle
	var score_side
	
	match side:
		GlobalEnums.PaddleSide.LEFT:
			paddle = score_1
			score_side = 0
		GlobalEnums.PaddleSide.RIGHT:
			paddle = score_2
			score_side = 1
	if GlobalVariables.score[score_side] < 7: 
		SfxManager.play_sound(SfxManager.sfx_point_scored)
	var tween = get_tree().create_tween()
	tween.tween_property(paddle, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(paddle, "scale", Vector2(1, 1), 0.1)
