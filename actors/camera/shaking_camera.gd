extends Camera2D

export(float) var amplitude = 6.0
#export(float) var duration = 1.0 setget set_duration

enum STATES {IDLE, SHAKING}
var state = IDLE
var start_position = Vector2()

func _ready():
	set_as_toplevel(true)
	set_process(false)
	start_position = global_position
	randomize()


func start_shake():
	_change_state(SHAKING)


func _change_state(new_state):
	match new_state:
		IDLE:
			position = start_position
			set_process(false)
		SHAKING:
			start_position = position
			set_process(true)
			$ShakeTimer.start()
	state = new_state


func _process(delta):
	var shake_offset = Vector2(
		rand_range(amplitude, -amplitude),
		rand_range(amplitude, -amplitude))
	position = start_position + shake_offset


func _on_ShakeTimer_timeout():
	_change_state(IDLE)


func _on_WildBoar_phase_changed(new_phase_name):
	start_shake()
