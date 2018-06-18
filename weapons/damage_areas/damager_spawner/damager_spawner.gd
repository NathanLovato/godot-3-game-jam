extends Node2D

export(int) var DAMAGE = 2
export(PackedScene) var Damager
var active = false setget set_active

func set_active(value):
	active = value
	if active:
		$SpawnTimer.start()
	else:
		$SpawnTimer.stop()

func _on_SpawnTimer_timeout():
	var damager = Damager.instance()
	damager.damage = DAMAGE
	add_child(damager)
