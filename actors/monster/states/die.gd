extends "res://utils/states/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("die")

func _on_animation_finished(anim_name):
	emit_signal("finished", "dead")
