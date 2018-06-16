extends 'res://actors/damage_source.gd'

signal attack_finished

enum STATES { IDLE, ATTACK }
var state = null

enum ATTACK_INPUT_STATES { IDLE, LISTENING, REGISTERED }
var attack_input_state = IDLE

var ready_for_next_attack = false

const MAX_COMBO_COUNT = 3
var combo_count = 0

var attack_current = {}
var combo = [{
		'damage': 1,
		'animation': 'attack_fast',
		'effect': null
	},
	{
		'damage': 1,
		'animation': 'attack_fast',
		'effect': null
	},
	{
		'damage': 3,
		'animation': 'attack_medium',
		'effect': null
	}]


func _ready():
	$AnimationPlayer.connect('animation_finished', self, "_on_animation_finished")
	_change_state(IDLE)


func _change_state(new_state):
	match state:
		ATTACK:
			attack_input_state = IDLE
			ready_for_next_attack = false

	match new_state:
		IDLE:
			combo_count = 0
			$AnimationPlayer.stop()
			visible = false
			$CollisionPolygon2D.disabled = true
		ATTACK:
			attack_current = combo[combo_count -1]
			$AnimationPlayer.play(attack_current['animation'])
			visible = true
			
	state = new_state


func cancel_attack():
	_change_state(IDLE)


func _input(event):
	if not state == ATTACK:
		return
	if attack_input_state != LISTENING:
		return
	if event.is_action_pressed('attack'):
		attack_input_state = REGISTERED


func _physics_process(delta):
	# Force area overlap checks to update
	position = position
	if attack_input_state == REGISTERED and ready_for_next_attack:
		attack()


func attack():
	combo_count += 1
	_change_state(ATTACK)


# use with AnimationPlayer func track
func set_attack_input_listening():
	attack_input_state = LISTENING


# use with AnimationPlayer func track
func set_ready_for_next_attack():
	ready_for_next_attack = true

func _on_animation_finished(name):
	if not attack_current:
		return

	if attack_input_state == REGISTERED and combo_count < MAX_COMBO_COUNT:
		attack()
	else:
		_change_state(IDLE)
		emit_signal("attack_finished")
