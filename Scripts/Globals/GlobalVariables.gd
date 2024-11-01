extends Node

var game_mode : GlobalEnums.GameMode
var game_status : GlobalEnums.GameStatus
var score := []
var ball_position : Vector2

func _ready():
	game_status = GlobalEnums.GameStatus.STOPPED
