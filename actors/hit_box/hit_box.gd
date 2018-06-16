extends Area2D

func _on_HitBox_area_entered(area):
	owner.take_damage_from(area)
