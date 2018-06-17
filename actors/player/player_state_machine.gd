extends Node

signal state_changed(current_state)

var states_stack = []
var current_state = null
var _state_machine_active = true

onready var states_map = {
	"idle": $Idle,
	"move": $Move,
	"dash": $Dash,
	"stagger": $Stagger,
	"recovery": $Recovery,
	"die": $Die,
}

func _ready():
	for child in get_children():
		child.connect("finished", self, "_change_state")

	states_stack.push_front($Idle)
	current_state = states_stack[0]
	_change_state("idle")

func _input(event):
	current_state.handle_input(event)

func _physics_process(delta):
	current_state.update(delta)

func _on_animation_finished(anim_name):
	current_state._on_animation_finished(anim_name)

func _change_state(state_name):
	if state_name == "dead":
		queue_free()
	if not _state_machine_active:
		return

	current_state.exit()
	
	if state_name == "die":
		_state_machine_active = false
		states_stack = []
		states_stack.push_front(states_map[state_name])
		current_state = states_stack[0]
		current_state.enter()
		return

	if state_name == "previous":
		states_stack.pop_front()
	elif state_name in ["stagger"]:
		states_stack.push_front(states_map[state_name])
	elif state_name == "dead":
		queue_free()
		return
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state
	
	current_state = states_stack[0]
	if state_name != "previous":
		current_state.enter()
	emit_signal("state_changed", current_state)

func _on_Health_health_depleted():
	_change_state("die")

func _on_Health_took_damage(amount):
	_change_state("stagger")

func _on_WeaponStateMachine_exploded():
	_change_state("recovery")
