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
var previoustimeflip
var healthPoint
var alive
var fliping

# Called when the node enters the scene tree for the first time.
func _ready():
	other = self.get_parent().get_node("UFTKA")
	animation_player = get_node("AnimationPlayer")
	timel = 0
	previoustime = 0
	previoustimeflip = 0
	healthPoint = 5
	alive = true
	fliping = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(alive):
		timel += delta
		if state == "walking":
			toward_player()
			previoustime = timel
		else:
			if(timel - previoustime > 0.5):
				previoustime = timel
				print("ia : state -", state, " inAction-", inAction, " AnimationPlayer.is_playing() -",$AnimationPlayer.is_playing()," fliping-",fliping)
				match state:
					"attack":
						attack()
					"spe":
						spe_attack()
					"taunt":
						taunt()
					"waiting":
						waiting()
			if(timel - previoustimeflip > 1.5):
				previoustimeflip = timel
				testFlip()
			
#	pass
func testFlip():
	var scale = self.scale.x
	var newscale
	if(self.global_position.x-other.global_position.x<0):
		newscale = 1
	else:
		newscale = - 1
	if(scale != newscale):
		fliping = true
		if($AnimationPlayer.is_playing()):
			yield($AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(0.5), "timeout")
		state = "fliping"
		self.scale.x = newscale
		yield(get_tree().create_timer(0.8), "timeout")
		fliping = false
		state = randomAttack()
		
func waiting():
	#print("wait")
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		if(abs(other.global_position.x-self.global_position.x) < distancewait):
			state ="walking"

func attack():
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		inAction = true
		if(abs(other.global_position.x-self.global_position.x) > distance):
			state = "walking"
		else:
			$AnimationPlayer.play("attack")
			#animation_player.connect("finished", animation_player, "stop")
			var tmp = randomAttack()
			var cd = 0.8
			if(tmp=="attack"):
				cd = 0.5
			#inAction = cooldown(cd)# real cd = 0.7 -> time attack = 0.614
			yield($AnimationPlayer, "animation_finished")
			yield(get_tree().create_timer(cd), "timeout")
			inAction = false
			state = tmp

func spe_attack():
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		inAction = true
		if(abs(other.global_position.x-self.global_position.x) > distance):
			state = "walking"
		else:
			$AnimationPlayer.play("spe_attack")
			#animation_player.connect("finished", animation_player, "stop")
			var tmp = randomAttack()
			var cd = 0.8
			if(tmp=="spe"):
				cd = 1.2
			yield($AnimationPlayer, "animation_finished")
			yield(get_tree().create_timer(cd), "timeout")# real cd = 0.7 -> time attack = 2.19
			inAction = false
			state = tmp

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
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		inAction = true
		$AnimationPlayer.play("taunt")
		#animation_player.connect("finished", animation_player, "stop")
		var tmp = randomAttack()
		var cd = 1.3
		if(tmp=="taunt"):
			cd = 0.915
		#inAction = cooldown(cd)# time attack = 1
		yield(get_tree().create_timer(cd), "timeout")
		inAction = false
		state = tmp

func randomAttack():
	var action = randi() % 13
	if action < 7:
		return "attack"
	elif action < 9:
		return "spe"
	else: return "taunt"
	
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
