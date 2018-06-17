extends Node

signal temperature_changed(percentage)

export(float) var MAX_RATE = 20.0
export(float) var BASE_COOLING_RATE = 4.0
export(float) var MAX_TEMPERATURE = 110.0

var temperature = 0.0

var _weapon = null
var _cooling_sources = []

func _process(delta):
	var rate = 0.0
	if _weapon:
		rate += _weapon.HEATING_RATE
	for source in _cooling_sources:
		rate -= source.COOLING_RATE
	rate -= BASE_COOLING_RATE
	
	var new_temperature = temperature + rate * delta
	new_temperature = clamp(new_temperature, 0.0, MAX_TEMPERATURE)
	if new_temperature == temperature:
		return
	
	temperature = new_temperature
	emit_signal("temperature_changed", new_temperature)

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
