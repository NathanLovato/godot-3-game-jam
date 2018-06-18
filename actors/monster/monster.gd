extends KinematicBody2D

onready var target = find_target()

func _ready():
	target.connect("tree_exited", self, "remove_target")

func find_target():
	for node in get_tree().get_nodes_in_group("actor"):
		if node.name == "Player":
			return node

func remove_target():
	target = null
	$StateMachine.set_active(false)

func take_damage_from(attacker):
	$Health.take_damage_from(attacker)
