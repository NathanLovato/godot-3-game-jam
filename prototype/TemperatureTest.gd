extends Node

func _input(event):
	if event.is_action_pressed("mouse_left"):
		$Temperature.increase(10.0)
	elif event.is_action_released("mouse_right"):
		$Temperature.decrease_rate(10.0)
	elif event.is_action_pressed("mouse_right"):
		$Temperature.increase_rate(10.0)
	if event.is_action_pressed("ui_down"):
		$Temperature.decrease(10.0)
		
