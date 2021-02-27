extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = "waiting"
var other#=preload("blanknode2D.tscn")
var distance = 200
var distancewait = 900
var inAction = false
var animation_player
var timel
var previoustime
var healthPoint
var alive
var tapped

# Called when the node enters the scene tree for the first time.
func _ready():
	other = self.get_parent().get_child(2)
	animation_player = get_node("AnimationPlayer")
	timel = 0
	previoustime = 0
	healthPoint = 5
	alive = true
	tapped =false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(alive):
		timel += delta
		if state == "walking":
			toward_player()
			if(timel - previoustime > 0.5):
				previoustime = timel
		else:
			if(timel - previoustime > 0.5):
				previoustime = timel
				match state:
					"attack":
						attack()
					"spe":
						spe_attack()
					"taunt":
						taunt()
					"waiting":
						waiting()
				if(timel>20 && !tapped):
					tapped =true
					takehit(4)
				if(timel>30):
					takehit(1)
			
#	pass
func waiting():
	#print("wait")
	if(!inAction && !$AnimationPlayer.is_playing()):
		if(abs(other.global_position.x-self.global_position.x) < distancewait):
			state ="walking"

func attack():
	if(!inAction && !$AnimationPlayer.is_playing()):
		inAction = true
		if(abs(other.global_position.x-self.global_position.x) > distance):
			state = "walking"
		else:
			$AnimationPlayer.play("attack")
			#animation_player.connect("finished", animation_player, "stop")
			cooldown(1.314)# real cd = 0.7 -> time attack = 0.614

func spe_attack():
	if(!inAction && !$AnimationPlayer.is_playing()):
		inAction = true
		if(abs(other.global_position.x-self.global_position.x) > distance):
			state = "walking"
		else:
			$AnimationPlayer.play("spe_attack")
			#animation_player.connect("finished", animation_player, "stop")
			cooldown(2.89)# real cd = 0.7 -> time attack = 2.19

func toward_player():
	var move
	if(abs(other.global_position.x-self.global_position.x) < distance):
		state = "attack"
		inAction = false
	else:
		#print("move")
		$AnimationPlayer.play("Walk")
		if(self.global_position.x-other.global_position.x<0):
			self.scale.x = 1
			move = 1
		else:
			self.scale.x = - 1
			move = -1
		self.global_position.x+=move
		
func taunt():
	if(!inAction && !$AnimationPlayer.is_playing()):
		inAction = true
		$AnimationPlayer.play("taunt")
		#animation_player.connect("finished", animation_player, "stop")
		cooldown(1.7)# real cd = 0.7 -> time attack = 2.19

func randomAttack():
	var action = randi() % 20
	if action < 8:
		state = "attack"
	else:
		if action < 10:
			state = "spe"
		else: state = "taunt"
		
func cooldown(time):
	var timer=Timer.new()
	timer.connect("timeout", self,"actionFinished")
	timer.set_wait_time(time)
	add_child(timer)
	timer.start()

func actionFinished():
	randomAttack()
	inAction = false

func takehit(hitvalue):
	healthPoint -= hitvalue
	force_action_end()
	if(healthPoint>0):
		$AnimationPlayer.play("takehit")
		state = "waiting"
	else:
		$AnimationPlayer.play("Die")
		alive = false
	
func force_action_end():
	$AnimationPlayer.stop()
