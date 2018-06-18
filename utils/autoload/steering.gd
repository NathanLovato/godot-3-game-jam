extends Node

const DEFAULT_MASS = 2.0
const DEFAULT_SLOW_RADIUS = 200.0
const DEFAULT_MAX_SPEED = 300.0

func follow(velocity,
			position_current,
			position_target,
			max_speed,
			MASS=DEFAULT_MASS):
	"""
	Calculates and returns a new velocity with the follow steering behavior
	"""
	var desired_velocity = (position_target - position_current).normalized() * max_speed
	var steering = (desired_velocity - velocity) / MASS
	return velocity + steering


func arrive_to(velocity,
			   position_current,
			   position_target,
			   mass=DEFAULT_MASS,
			   slow_radius=DEFAULT_SLOW_RADIUS,
			   max_speed=DEFAULT_MAX_SPEED):
	"""
	Calculates and returns a new velocity with the arrive steering behavior
	"""
	var distance_to_target = position_current.distance_to(position_target)

	var desired_velocity = (position_target - position_current).normalized() * max_speed
	if distance_to_target < slow_radius:
		desired_velocity *= (distance_to_target / slow_radius) * .75 + .25
	var steering = (desired_velocity - velocity) / mass

	return velocity + steering
