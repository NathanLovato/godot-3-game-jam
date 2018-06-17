extends "../motion/motion.gd"

func enter():
	owner.get_node("AnimationPlayer").play("idle")

func _on_Sword_attack_finished():
	emit_signal("finished", "previous")

func update(delta):
	update_look_direction(get_input_direction())
