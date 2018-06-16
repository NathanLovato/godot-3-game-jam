extends "res://utils/states/state2d.gd"

export(float) var SPEED = 400.0

func set_active(value):
	$Particles.active = value
	$DamagerSpawner.active = value

func enter():
	set_active(true)

func update(delta):
	rotation = (get_global_mouse_position() - global_position).angle()

func handle_input(event):
	if event.is_action_pressed("mouse_left"):
		emit_signal("finished", "wave")
	elif event.is_action_released("mouse_right"):
		emit_signal("finished")

func exit():
	set_active(false)
