extends Node2D

var weapon_current = null
onready var weapons = {
	"": null,
	"fireball": $FireballThrower,
	"flamethrower": $Flamethrower,
	"wave": $FireWave,
}

func _ready():
	_set_weapon_active("")
	for weapon in get_children():
		weapon.connect("finished", self, "_set_weapon_active")

func _set_weapon_active(weapon_name=""):
	if weapon_current:
		weapon_current.exit()
	weapon_current = weapons[weapon_name]
	if weapon_current:
		print(weapon_current.name)

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

	# input L + R should:
	# cancel flamethrow/fireball
	# go to firewave
#	if event.is_action_pressed("mouse_left") and weapon_current == $Flamethrower:
#		_set_weapon_active("wave")
#	elif event.is_action_pressed("mouse_right") and weapon_current == $FireballThrower:
#		_set_weapon_active("wave")
	if event.is_action_pressed("mouse_left"):
		_set_weapon_active("fireball")
	elif event.is_action_pressed("mouse_right"):
		_set_weapon_active("flamethrower")
