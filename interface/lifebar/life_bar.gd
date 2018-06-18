extends Node2D

var max_health = 0 setget set_max_health
var health = 0 setget set_health

func set_max_health(value):
	max_health = value
	$Bar.max_value = value
	
func set_health(value):
	health = value
	$Bar.value = value

func _on_Actor_health_changed(new_health):
	self.health = new_health
	print(health)

func _on_Actor_health_depleted():
	queue_free()
