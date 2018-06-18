extends "res://utils/states/state.gd"

export(float) var MAX_SPEED = 300.0
export(float) var MAX_DISTANCE = 400.0

var velocity = Vector2()

func exit():
	velocity = Vector2()

func update(delta):
	var target_position = owner.target.global_position
	velocity = Steering.follow(velocity, owner.global_position, target_position, MAX_SPEED)
	owner.move_and_slide(velocity)

	if owner.global_position.distance_to(target_position) > MAX_DISTANCE:
		emit_signal("finished", "idle")
