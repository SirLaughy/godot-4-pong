extends Node

class_name Global

# the type of game to play
enum GameMode{SINGLEPLAYER, MULTIPLAYER}

# the status the game is in
enum GameStatus{RUNNING, STOPPED}

# the scaling direction
enum InOutDirection{IN, OUT}

# horizontal direction	
enum Direction{LEFT, RIGHT}

# the game scene
enum GameScenes{MAIN_MENU, PAUSE_MENU, OPTIONS_MENU, CONTROLS_MENU, GAME_SCENE}

enum PaddleSide{LEFT, RIGHT}

enum PaddleController{PLAYER_1, PLAYER_2, CPU}
