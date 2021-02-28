extends Node

signal health_changed(health)
#signal health_depleted

var health = 50
export(int) var max_health = 100

func _ready():
	health = max_health
	emit_signal("health_changed", health)
	print("TEST")

func take_damage(amount):
	health = max(0, health - amount)
	emit_signal("health_changed", health)

func heal(amount):
	health = max(max_health, health + amount)
	emit_signal("health_changed", health)
