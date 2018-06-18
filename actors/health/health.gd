extends Node

signal took_damage(amount)
signal health_changed(new_health)
signal status_changed(new_status)
signal health_depleted

var health = 0
export(int) var max_health = 9

var status = null
const BURN_DAMAGE = 1

func _ready():
	health = max_health
	$BurnTimer.connect('timeout', self, '_on_BurnTimer_timeout')

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
#	print("%s got healed by %s points. Health: %s/%s" % [get_name(), amount, health, max_health])

func take_damage_from(source):
	take_damage(source.damage)
	if not source.effect:
		return
	apply_status(source.effect)

func take_damage(amount):
	if health == 0 or status == GlobalConstants.STATUS_INVINCIBLE:
		return
	health -= amount
	health = max(0, health)
	if health == 0:
		emit_signal("health_depleted")
		return
	else:
		emit_signal("took_damage", amount)
		emit_signal("health_changed", health)
#	print("%s got hit and took %s damage. Health: %s/%s" % [get_name(), amount, health, max_health])

func apply_status(effect):
	match effect[0]:
		GlobalConstants.STATUS_BURNING:
			_change_status(GlobalConstants.STATUS_BURNING)

func _change_status(new_status):
	match status:
		GlobalConstants.STATUS_BURNING:
			$BurnTimer.stop()

	match new_status:
		GlobalConstants.STATUS_BURNING:
			$BurnTimer.start()
	status = new_status
	emit_signal('status_changed', new_status)

func _on_BurnTimer_timeout():
	take_damage(BURN_DAMAGE)

func _on_WeaponStateMachine_exploded():
	take_damage(10)

func _on_Temperature_burning(burning):
	if burning:
		_change_status(GlobalConstants.STATUS_BURNING)
	else:
		_change_status(GlobalConstants.STATUS_NONE)
