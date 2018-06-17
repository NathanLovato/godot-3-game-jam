extends "../damage_source.gd"

func _on_Timer_timeout():
	queue_free()
