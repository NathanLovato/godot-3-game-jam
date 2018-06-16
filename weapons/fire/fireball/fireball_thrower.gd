extends "res://utils/states/state.gd"

export(PackedScene) var Fireball
export(PackedScene) var FireballBig
export(float) var CHARGE_THRESHOLD = 0.8

var _charge_timer = 0.0

func enter():
	_charge_timer = 0.0

func handle_input(event):
	if event.is_action_pressed("mouse_right"):
		emit_signal("finished", "wave")

func update(delta):
	if not $CooldownTimer.is_stopped():
		emit_signal("finished")
		return
		
	if Input.is_action_pressed("mouse_left"):
		_charge_timer += delta
	elif Input.is_action_just_released("mouse_left"):
		var direction = get_local_mouse_position().normalized()
		if _charge_timer > CHARGE_THRESHOLD:
			spawn_projectile(FireballBig, direction)
		else:
			spawn_projectile(Fireball, direction)
		emit_signal("finished")

func spawn_projectile(bullet_scene, direction):
	var fireball = bullet_scene.instance()
	fireball.direction = direction
	add_child(fireball)

	$CooldownTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
