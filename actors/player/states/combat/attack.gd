"""
The stagger state end with the stagger animation from the AnimationPlayer
The animation only affects the Body Sprite"s modulate property so 
it could stack with other animations if we had two AnimationPlayer nodes
"""
extends "../motion/motion.gd"


func enter():
	owner.get_node("AnimationPlayer").play("idle")


func _on_Sword_attack_finished():
	emit_signal("finished", "previous")


func update(delta):
	update_look_direction(get_input_direction())
