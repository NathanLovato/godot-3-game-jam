extends Node

signal temperature_changed(new_temperature)
signal burning(value)
signal overheated

export(float) var MAX_RATE = 20.0
export(float) var BASE_COOLING_RATE = 4.0
export(float) var MAX_TEMPERATURE = 110.0
export(float) var BURNING_THRESHOLD = 80.0

export(float) var temperature = 0.0

var _weapon = null
var _cooling_sources = []
var _overheated = false
var _burning = false
var _recovering = false

func _process(delta):
	var rate = calculate_heating_rate()
	
	var new_temperature = temperature + rate * delta
	if new_temperature == temperature:
		return
	temperature = clamp(new_temperature, 0.0, MAX_TEMPERATURE)
	emit_signal("temperature_changed", new_temperature)
	
	if temperature == MAX_TEMPERATURE and not _overheated:
		_overheated = true
		emit_signal("overheated")
	elif temperature < MAX_TEMPERATURE and _overheated:
		_overheated = false

	if temperature > BURNING_THRESHOLD and not _burning:
		_burning = true
		emit_signal("burning", _burning)
	if temperature < BURNING_THRESHOLD and _burning:
		_burning = false
		emit_signal("burning", _burning)

func calculate_heating_rate():
	var rate = 0.0
	if _weapon:
		rate += _weapon.HEATING_RATE
	for source in _cooling_sources:
		rate -= source.COOLING_RATE
	rate -= BASE_COOLING_RATE
	return rate

func increase(amount):
	temperature += amount
	temperature = min(temperature, MAX_TEMPERATURE)
	emit_signal("temperature_changed", temperature)

func decrease(amount):
	temperature -= amount
	temperature = max(0.0, temperature)
	emit_signal("temperature_changed", temperature)

func _on_WaterDetector_water_entered(area):
	_cooling_sources.append(area)

func _on_WaterDetector_water_exited(area):
	_cooling_sources.remove(_cooling_sources.find(area))

func _on_WeaponStateMachine_weapon_changed(new_weapon):
	_weapon = new_weapon
	if new_weapon:
		increase(new_weapon.TEMPERATURE_COST)

func _on_StateMachine_state_changed(current_state):
	if current_state.name == "Recovery":
		_recovering = true
		_cooling_sources.append($RecoveryCooler)
	elif _recovering:
		_recovering = false
		_cooling_sources.remove(_cooling_sources.find($RecoveryCooler))
