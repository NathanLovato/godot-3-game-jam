extends Node2D

signal weapon_changed(weapon)
signal exploded

var weapon_current = null
onready var weapons = {
	"": null,
	"fireball_small": $FireballThrowerSmall,
	"fireball_big": $FireballThrowerBig,
	"flamethrower": $Flamethrower,
	"wave": $FireWave,
	"explode": $ExplodeSpawner,
}

var _controlable = true

func _ready():
	for child in get_children():
		if not child.is_class("Node2D"):
			continue
		child.connect("finished", self, "_set_weapon_active")
	_set_weapon_active("")

func _set_weapon_active(weapon_name=""):
	if not _controlable:
		return

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

func _on_Temperature_overheated():
	if weapon_current == weapons["wave"]:
		_set_weapon_active("explode")

func _on_ExplodeSpawner_exploded():
	emit_signal("exploded")

func _on_Health_health_depleted():
	_set_weapon_active("")
	set_controlable(false)

func set_controlable(value):
	_controlable = value
	set_process_input(value)
	set_physics_process(value)

func _on_Health_took_hit():
	_set_weapon_active("")
