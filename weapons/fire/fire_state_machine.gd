extends Node2D

signal weapon_changed(weapon)

var weapon_current = null
onready var weapons = {
	"": null,
	"fireball_small": $FireballSmall,
	"fireball_big": $FireballBig,
	"flamethrower": $Flamethrower,
	"wave": $FireWave,
}

func _ready():
	_set_weapon_active("")
	for child in get_children():
		if not child.is_class("Node2D"):
			continue
		child.connect("finished", self, "_set_weapon_active")

func _set_weapon_active(weapon_name=""):
	$FireballChargeTimer.stop()

	if weapon_current:
		weapon_current.exit()
	weapon_current = weapons[weapon_name]
	emit_signal("weapon_changed", weapon_current)

	if not weapon_current:
		set_physics_process(false)
		return

	set_physics_process(true)
	weapon_current.enter()

func _physics_process(delta):
	weapon_current.update(delta)

func _input(event):
	if weapon_current:
		weapon_current.handle_input(event)
		return

	# Firewave
	if event.is_action_pressed("mouse_left") and Input.is_action_pressed("mouse_right"):
		_set_weapon_active("wave")
	elif event.is_action_pressed("mouse_right") and Input.is_action_pressed("mouse_left"):
		_set_weapon_active("wave")
	# Fireballs
	elif event.is_action_pressed("mouse_left"):
		$FireballChargeTimer.start()
	elif event.is_action_released("mouse_left"):
		if $FireballChargeTimer.time_left == 0.0:
			_set_weapon_active("fireball_big")
		else:
			_set_weapon_active("fireball_small")
		$FireballChargeTimer.stop()
	# Flamethrower
	elif event.is_action_pressed("mouse_right"):
		_set_weapon_active("flamethrower")
