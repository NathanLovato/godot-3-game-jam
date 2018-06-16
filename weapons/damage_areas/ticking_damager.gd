extends "damage_source.gd"

var active = false setget set_active

func _on_Timer_timeout():
	set_active(true)
	get_tree().create_timer(0.1).connect("timeout", self, "set_active", [false])

func set_active(value):
	active = value
	monitorable = value
	visible = value
