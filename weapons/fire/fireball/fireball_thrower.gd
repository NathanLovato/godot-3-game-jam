extends "res://weapons/weapon.gd"

export(PackedScene) var Fireball

func update(delta):
	if not $CooldownTimer.is_stopped():
		emit_signal("finished")
		return

	var direction = get_local_mouse_position().normalized()
	spawn_projectile(direction)
	emit_signal("finished")

func spawn_projectile(direction):
	var fireball = Fireball.instance()
	fireball.direction = direction
	fireball.set_as_toplevel(true)
	fireball.position = global_position
	add_child(fireball)

	$CooldownTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
