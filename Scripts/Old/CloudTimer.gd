extends GPUParticles2D

@export var on_time : float
@export var off_time : float

@onready var on_timer = $OnTimer
@onready var off_timer = $OffTimer


func _ready():
	on_timer.timeout.connect(on_on_timer_timeout)
	off_timer.timeout.connect(on_off_timer_timeout)
	on_timer.start()
	emitting = true

func on_on_timer_timeout():
	off_timer.start()
	emitting = false

func on_off_timer_timeout():
	on_timer.start()
	emitting = true
