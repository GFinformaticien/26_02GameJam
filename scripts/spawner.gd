extends Node2D

export var Mob: PackedScene
var mobTimer = null
var SPAWN_INTERVAL = 4
export var enabled: bool = false

func _ready():
	mobTimer = Timer.new()
	mobTimer.connect("timeout", self, "_on_mob_timer")
	add_child(mobTimer)
	mobTimer.start(SPAWN_INTERVAL)

func _on_mob_timer():
	if(enabled):
		var playerPosition = get_node("UFTKA").transform.get_origin()
		var x = playerPosition.x
		var y = playerPosition.y
		var newMob = Mob.instance()
		newMob.position = Vector2(x - 200, y)
		add_child(newMob)
