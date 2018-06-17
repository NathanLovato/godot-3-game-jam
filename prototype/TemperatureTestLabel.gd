extends Label

export(NodePath) var temperature_node_path
onready var temperature_node = get_node(temperature_node_path)

func _on_Temperature_temperature_changed(percentage):
	var cooling_rate = temperature_node.BASE_COOLING_RATE
	text = 	"""
			Temperature: %.1f
			""" % [percentage]
