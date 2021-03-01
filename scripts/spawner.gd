extends Node2D

export var ia: PackedScene
export var cat: PackedScene
export var puggu: PackedScene
export var enabled: bool = false

var spawnY = 0
var player: Node2D

var SPAWNS = [
	[800, [
		["ia",200],
		["ia",350],
		["ia",325],
		["ia",1200],
		["ia",1250]
	]],
	[1400, [
		["ia",800],
		["ia",800],
		["ia",1900],
		["ia",1950],
		["cat",2000]
	]],
	[2500, [
		["cat",1850],
		["ia",1900],
		["cat",2800],
		["ia",2850],
		["cat",2900]
	]],
	[3500, [
		["cat",2750],
		["ia",2600],
		["cat",3900],
		["cat",4050],
		["cat",4100]
	]],
	[4500, [
		["ia",3800],
		["ia",3900],
		["ia",4800],
		["ia",4950],
		["ia",5000]
	]],
	[6000, [
		["cat",5200],
		["cat",5350],
		["ia",6700],
		["puggu",6800],
		["ia",6900],
		["cat",7050],
		["cat",7250]
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
