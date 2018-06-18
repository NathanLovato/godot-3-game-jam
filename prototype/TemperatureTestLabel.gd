extends Label

export(NodePath) var temperature_node_path
onready var temperature_node = get_node(temperature_node_path)

func _process(delta):
	text = "Temperature: %.1f" % [temperature_node.temperature]
