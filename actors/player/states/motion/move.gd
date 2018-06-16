extends "motion.gd"

export(float) var SPEED_NORMAL = 700
export(float) var SPEED_SLOW = 450

func enter():
	update_look_direction(get_input_direction())
	owner.get_node("AnimationPlayer").play("walk")

func handle_input(event):
	if event.is_action_pressed("mouse_right"):
		emit_signal("finished", "dash")

func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
		return
	update_look_direction(input_direction)

	speed = SPEED_SLOW if Input.is_action_pressed("mouse_right") else SPEED_NORMAL
	owner.move(input_direction.normalized() * speed)
