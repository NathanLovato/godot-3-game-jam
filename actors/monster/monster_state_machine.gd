extends "res://utils/states/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"follow": $Follow,
		"die": $Die,
	}

func _on_Health_health_depleted():
	_change_state("die")
