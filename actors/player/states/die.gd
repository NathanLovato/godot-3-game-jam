extends "res://utils/states/state.gd"


# Initialize the state. E.g. change the animation
func enter():
	owner.get_node("AnimationPlayer").play("die")


func _on_animation_finished(anim_name):
	emit_signal("finished", "dead")
