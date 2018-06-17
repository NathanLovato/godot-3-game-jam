extends Area2D

signal water_entered(cooling_rate)
signal water_exited(cooling_rate)

func _ready():
	self.connect("area_entered", self, "_on_area_entered")
	self.connect("area_exited", self, "_on_area_exited")

func _on_area_entered(water_area):
#	print("entered %s" % water_area.name)
	emit_signal("water_entered", water_area)

func _on_area_exited(water_area):
#	print("exited %s" % water_area.name)
	emit_signal("water_exited", water_area)
