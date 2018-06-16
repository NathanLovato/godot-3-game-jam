extends Area2D

signal toggled_active

export(PackedScene) var Collider
var active = false setget set_active

func set_active(value):
	active = value
	if not has_node("SpawnTimer"):
		return
	if active:
		$SpawnTimer.start()
	else:
		$SpawnTimer.stop()


func _on_SpawnTimer_timeout():
	add_child(Collider.instance())
