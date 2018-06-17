extends Node

signal health_changed
signal took_damage(amount)
signal health_depleted
signal status_changed

var health = 0
export(int) var max_health = 9

var status = null
const POISON_DAMAGE = 1
var poison_cycles = 0

func _ready():
	health = max_health
	$PoisonTimer.connect('timeout', self, '_on_PoisonTimer_timeout')

func _change_status(new_status):
	match status:
		GlobalConstants.STATUS_POISONED:
			$PoisonTimer.stop()

	match new_status:
		GlobalConstants.STATUS_POISONED:
			poison_cycles = 0
			$PoisonTimer.start()
	status = new_status
	emit_signal('status_changed', new_status)

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
#	print("%s got hit and took %s damage. Health: %s/%s" % [get_name(), amount, health, max_health])

func apply_status(effect):
	match effect[0]:
		GlobalConstants.STATUS_POISONED:
			_change_status(GlobalConstants.STATUS_POISONED)
			poison_cycles = effect[1]

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
#	print("%s got healed by %s points. Health: %s/%s" % [get_name(), amount, health, max_health])

func _on_PoisonTimer_timeout():
	take_damage(POISON_DAMAGE)
	poison_cycles -= 1
	if poison_cycles == 0:
		_change_status(GlobalConstants.STATUS_NONE)
		return
	$PoisonTimer.start()

func _on_WeaponStateMachine_exploded():
	take_damage(10)
