extends Node

export(PackedScene) var Lifebar

func _ready():
	for spawner in get_tree().get_nodes_in_group("monster_spawner"):
		spawner.connect("spawned_monster", self, "_on_MonsterSpawner_spawned_monster")
	for actor in get_tree().get_nodes_in_group("actor"):
		create_lifebar(actor)

func create_lifebar(actor):
	if not actor.has_node("Health") or not actor.has_node("InterfaceAnchor"):
		return

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

func _on_MonsterSpawner_spawned_monster(new_monster):
	create_lifebar(new_monster)
