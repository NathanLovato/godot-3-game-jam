extends Node2D

func take_damage_from(attacker):
	if not has_node("Health"):
		return
	$Health.take_damage_from(attacker)
	print("%s takes %s damage from %s" % [name, attacker.damage, attacker.name])
	
