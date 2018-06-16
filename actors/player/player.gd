extends KinematicBody2D

signal state_changed
signal direction_changed(new_direction)
signal position_changed(new_position)

var look_direction = Vector2(1, 0) setget set_look_direction

func _input(event):
	if event.is_action_pressed("fire"):
		$BulletSpawn.fire(look_direction)
		return
	current_state.handle_input(event)


func take_damage_from(attacker):
	if current_state == $States/Stagger:
		return
	cancel_attack()
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage_from(attacker)


func set_controlable(value):
	set_process_input(value)
	set_physics_process(value)
	$CollisionPolygon2D.disabled = not value


func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)


func move(velocity):
	move_and_slide(velocity)
	emit_signal("position_changed", global_position)
