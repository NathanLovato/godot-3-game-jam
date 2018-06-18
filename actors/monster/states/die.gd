extends "res://utils/states/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("die")
