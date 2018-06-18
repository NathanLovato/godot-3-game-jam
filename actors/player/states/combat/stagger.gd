extends "res://utils/states/state.gd"

var knockback_direction = Vector2()

func enter():
	owner.get_node("AnimationPlayer").play("stagger")
	emit_signal("finished", "previous")
