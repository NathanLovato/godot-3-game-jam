extends "../../weapon.gd"

func enter():
	set_active(true)

func exit():
	set_active(false)

func _ready():
	set_active(false)

func set_active(value):
	$RadiateFire.active = value
	$TickingDamager.active = value

func handle_input(event):
	if event.is_action_released("mouse_left") or event.is_action_released("mouse_right"):
		emit_signal("finished")
