extends KinematicBody2D

signal direction_changed(new_direction)
signal position_changed(new_position)

var look_direction = Vector2(1, 0) setget set_look_direction

func take_damage_from(attacker):
	if not has_node("Health"):
		return
	if $StateMachine.current_state in [$StateMachine/Stagger, $StateMachine/Dash]:
		return
	$StateMachine/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage_from(attacker)

func set_controlable(value):
	$StateMachine.set_process_input(value)
	$StateMachine.set_physics_process(value)
	$CollisionPolygon2D.disabled = not value

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func move(velocity):
	move_and_slide(velocity)
	emit_signal("position_changed", global_position)

func _on_Health_health_depleted():
	set_controlable(false)
