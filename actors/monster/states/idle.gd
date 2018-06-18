extends "res://utils/states/state.gd"

export(float) var FOLLOW_DISTANCE = 300.0

func enter():
	owner.get_node("AnimationPlayer").play("idle")

func update(delta):
	var target_position = owner.target.global_position
	if owner.global_position.distance_to(target_position) < FOLLOW_DISTANCE:
		emit_signal("finished", "follow")
