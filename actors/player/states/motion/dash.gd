extends "motion.gd"

export(float) var SPEED = 1300
export(int) var MAX_COUNT = 2

var direction = Vector2()
var count = 0

func enter():
	if count >= MAX_COUNT:
		emit_signal("finished", "move")
		return
	count += 1

	direction = get_input_direction()
	update_look_direction(direction)
	$Timer.start()

func update(delta):
	owner.move(direction.normalized() * SPEED)

func _on_Timer_timeout():
	$CooldownTimer.start()
	emit_signal("finished", "move")

func _on_CooldownTimer_timeout():
	count = 0
