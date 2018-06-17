extends "../../weapon.gd"

signal exploded

export(PackedScene) var Explode
var _exploding = false

func enter():
	_exploding = false
	$PrepareTimer.start()

func handle_input(event):
	if _exploding:
		return
	if event.is_action_released("mouse_left") or event.is_action_released("mouse_right"):
		emit_signal("finished")

func _on_PrepareTimer_timeout():
	explode()

func explode():
	var explosion = Explode.instance()
	explosion.connect("tree_exited", self, "emit_signal", ["finished"])
	add_child(explosion)
	_exploding = true
	emit_signal("exploded")
