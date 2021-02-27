extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = "waiting"
var other#=preload("blanknode2D.tscn")
var distance = 5
var distancewait = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	other = self.get_parent().get_child(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		"walking":
			toward_player()
		"light":
			light_attack()
		"attack":
			attack()
		"spe":
			spe_attack()
		"taunt":
			taunt()
		"waiting":
			waiting()
#	pass
func waiting():
	if(abs(other.global_position.x-self.global_position.x) < distancewait):
		state ="walking"
func light_attack():
	pass

func attack():
	pass

func spe_attack():
	pass

func toward_player():
	var move
	if(abs(other.global_position.x-self.global_position.x) < distance):
		state = "attack"
	else:
		if(self.global_position.x-other.global_position.x<0):
			move = 1
		else: move = -1
		self.global_position.x+=move
func taunt():
	pass
