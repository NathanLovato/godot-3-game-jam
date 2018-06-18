extends Node

export(PackedScene) var Lifebar

func _ready():
	create_lifebars()

func create_lifebars():
	for actor in get_tree().get_nodes_in_group("actor"):
		if not actor.has_node("Health") or not actor.has_node("InterfaceAnchor"):
			continue

		var lifebar = Lifebar.instance()
		add_child(lifebar)
		
		var anchor = actor.get_node("InterfaceAnchor")
		lifebar.global_position = anchor.global_position
		anchor.remote_path = NodePath(anchor.get_path_to(lifebar))
		
		var health_node = actor.get_node("Health")
		health_node.connect("health_changed", lifebar, "_on_Actor_health_changed")
		health_node.connect("health_depleted", lifebar, "_on_Actor_health_depleted")
		
		lifebar.max_health = health_node.max_health
		lifebar.health = health_node.health
