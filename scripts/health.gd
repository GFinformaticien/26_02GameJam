extends Node

signal health_changed(health)
#signal health_depleted

var health = 0
export(int) var max_health = 100

func _ready():
	health = max_health/2
	emit_signal("health_changed", health)
	print("TEST")

func take_damage(amount):
	health = max(0, health - amount)
	emit_signal("health_changed", health)
	if(health <= 0):
		get_tree().quit()


func heal(amount):
	health = max(max_health, health + amount)
	emit_signal("health_changed", health)
