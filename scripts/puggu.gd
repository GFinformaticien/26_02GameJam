extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = "waiting"
var other#=preload("blanknode2D.tscn")
var distance = 170
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
	healthPoint = 100
	alive =true
	fliping = false

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
	if(self.global_position.x-other.global_position.x>0):
		newscale = -1
	else:
		newscale =  1
	if(scale != newscale):
		fliping = true
		if($AnimationPlayer.is_playing()):
			yield($AnimationPlayer, "animation_finished")
		inAction = false
		state = "fliping"
		self.scale.x = newscale
		yield(get_tree().create_timer(0.5), "timeout")
		fliping = false
		state = randomAttack()
		
func waiting():
	#print("wait")
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		if(abs(other.global_position.x-self.global_position.x) < distancewait):
			state ="walking"

func attack():
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		#print("enter attack")
		inAction = true
		if(abs(other.global_position.x-self.global_position.x) > distance):
			state = "walking"
		else:
			$AnimationPlayer.play("HornyBonk")
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

func toward_player():
	var move
	if(abs(other.global_position.x-self.global_position.x) < distance):
		state = "attack"
		inAction = false
		#print("attack tp")
	else:
		#print("move")
		#$AnimationPlayer.play("walk")
		var scale_before = self.scale.x
		if(self.global_position.x-other.global_position.x<0):
			self.scale.x = 1
			move = 1
		else:
			self.scale.x = -1
			move = -1
		self.global_position.x+=move
		#print("moving",self.global_position.x)
		
func taunt():
	#print("taunt")
	if(!inAction && !$AnimationPlayer.is_playing() && !fliping):
		inAction = true
		#$AnimationPlayer.play("taunt")
		#animation_player.connect("finished", animation_player, "stop")
		var tmp = randomAttack()
		var cd = 0.8
		if(tmp=="taunt"):
			cd = 0.1
		#inAction = cooldown(cd)# time attack = 1
		#yield($AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(cd), "timeout")
		
		inAction = false
		state = tmp

func randomAttack():
	var action = randi() % 13
	#if action < 7:
	return "attack"
	#else: return "taunt"
	
func takehit(hitvalue):
	healthPoint -= hitvalue
	force_action_end()
	if(healthPoint>0):
		#$AnimationPlayer.play("takehit")
		state = "waiting"
	else:
		#$AnimationPlayer.play("Die")
		alive = false
		yield($AnimationPlayer, "animation_finished")
		queue_free()
	
func force_action_end():
	$AnimationPlayer.stop()
	


func _on_hurtbox_body_entered(body):
	print("something")
	if(body.name == "hitbox"):
		takehit(body.damage)
		print("puggu")
