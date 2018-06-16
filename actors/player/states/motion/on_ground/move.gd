extends "on_ground.gd"

export(float) var MAX_SPEED = 450

func enter():
	speed = 0.0
	velocity = Vector2()

	update_look_direction(get_input_direction())
	owner.get_node("AnimationPlayer").play("walk")


func handle_input(event):
	return .handle_input(event)


func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")

	update_look_direction(input_direction)

	speed = MAX_SPEED
	move(speed, input_direction)


func move(speed, direction):
	velocity = direction.normalized() * speed
	owner.move(velocity)
	if owner.get_slide_count() == 0:
		return
	return owner.get_slide_collision(0)
