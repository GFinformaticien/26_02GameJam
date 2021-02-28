extends Node

signal health_changed(health)


func _ready():
	var health_node = null
	for node in get_tree().get_nodes_in_group("actors"):
		if node.name == "UFTKA":
			health_node = node.get_node("Health")
			break
	$Bars/LifeBar.initialize(health_node.max_health)


func _on_Health_health_changed(health):
	emit_signal("health_changed", health)
	print("AIE")
