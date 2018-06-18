extends Area2D

export(float) var BASE_COOLING_RATE = 10.0
export(float) var REFILL_RATE = 5.0
export(float) var POOL_SIZE = 50.0

var cooling_rate = 0.0
var water = POOL_SIZE
var ratio = 0.0

func _process(delta):
	if len(get_overlapping_areas()) > 0:
		var cooling_amount = BASE_COOLING_RATE * delta
		if cooling_amount > water:
			water = 0.0
			cooling_rate = 0.0
		else:
			cooling_rate = BASE_COOLING_RATE
			water -= cooling_amount
	else:
		water += REFILL_RATE * delta
	water = min(water, POOL_SIZE)
	
	ratio = water / POOL_SIZE
	$Pivot.scale = Vector2(ratio, ratio)
