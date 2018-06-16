extends CollisionShape2D

var SPEED = 500
var LIFETIME = 0.8
onready var direction = (get_global_mouse_position() - global_position).normalized()

func _ready():
	set_as_toplevel(true)
	position = get_parent().global_position
	get_tree().create_timer(LIFETIME).connect("timeout", self, "queue_free")

func _physics_process(delta):
	position += SPEED * direction * delta
