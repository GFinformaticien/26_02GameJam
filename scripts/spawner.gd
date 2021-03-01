extends Node2D

export var ia: PackedScene
export var cat: PackedScene
export var puggu: PackedScene
export var enabled: bool = false

var spawnY = 0
var player: Node2D

var SPAWNS = [
	[800, [
		["ia",700],
		["ia",650],
		["ia",680],
		["ia",1000],
		["ia",1050]
	]],
]

func _process(delta):
	for i in SPAWNS.size():
		var spawner = SPAWNS[i] as Array
		# Activate if near 100 pixels
		if(abs(player.transform.get_origin().x - spawner[0]) <= 100):
			var mobsAndSpawn = spawner[1] as Array
			# Spawn all mobs inside
			for mobs in mobsAndSpawn:
				var mob: PackedScene = null
				match mobs[0] as String:
					"ia":
						mob = ia
					"cat":
						mob = cat
					"puggu":
						mob = puggu
				var newMob = mob.instance()
				newMob.get_node("Position2D").position = Vector2(mobs[1], spawnY)
				add_child(newMob)
			# remove from array
			SPAWNS.remove(i)
			return

func _ready():
	var playerPosition = get_node("SpawnOrigin").transform.get_origin()
	spawnY = playerPosition.y
	player = get_node("UFTKA")
