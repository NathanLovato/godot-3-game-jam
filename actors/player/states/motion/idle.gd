extends "motion.gd"

func enter():
	owner.get_node("AnimationPlayer").play("idle")

func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")

func handle_input(event):
	if event.is_action_pressed("mouse_right"):
		emit_signal("finished", "dash")
