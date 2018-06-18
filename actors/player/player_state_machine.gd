extends "res://utils/states/state_machine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"dash": $Dash,
		"stagger": $Stagger,
		"recovery": $Recovery,
		"die": $Die,
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["stagger"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

func _on_Health_health_depleted():
	_change_state("die")
	set_active(false)

func _on_Health_took_damage(amount):
	_change_state("stagger")

func _on_WeaponStateMachine_exploded():
	_change_state("recovery")
