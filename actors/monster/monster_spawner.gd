extends Position2D

signal spawned_monster(monster_node)

export(PackedScene) var Monster
export(NodePath) var SPAWN_PATH = NodePath(".")
export(int) var MAX_SPAWN_COUNT = 1

var count = 0

func _ready():
	spawn_monster()

func spawn_monster():
	if count == MAX_SPAWN_COUNT:
		$SpawnTimer.stop()
		return

	var new_monster = Monster.instance()
	new_monster.global_position = global_position
	new_monster.connect("tree_exited", self, "_on_Monster_tree_exited")
	get_node(SPAWN_PATH).add_child(new_monster)
	count += 1

	emit_signal("spawned_monster", new_monster)
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	spawn_monster()

func _on_Monster_tree_exited():
	count -= 1
	$SpawnTimer.start()
