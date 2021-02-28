extends Node2D


var timel
var previoustime
var dashing
var actual
var previous 

# Called when the node enters the scene tree for the first time.
func _ready():
	previoustime = 0
	timel = 0
	dashing = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#func _input(event):
	#if event.is_action_pressed("ui_weak"):
		#weak_attack()
	#elif event.is_action_pressed("ui_strong"):
		#strong_attack()

func weak_attack():
	print("Weak attack")
	pass

func strong_attack():
	print("Strong attack")
	pass

export var speed = 140

func _physics_process(delta):
	if(!dashing):
		var realspeed = 1
		if Input.is_key_pressed(KEY_SHIFT):
			realspeed = 2
		if Input.is_action_pressed("ui_right"):
			# Move as long as the key/button is pressed.
			self.scale.x = 1
			position.x += speed * delta * realspeed
			$AnimationPlayer.play("Walk")
		elif Input.is_action_pressed("ui_left"):
			self.scale.x = - 1
			position.x -= speed * delta * realspeed
			$AnimationPlayer.play("Walk")
		elif Input.is_key_pressed(KEY_1):
			$AnimationPlayer.play("foot")
		elif Input.is_key_pressed(KEY_2):
			$AnimationPlayer.play("fist")
		elif Input.is_key_pressed(KEY_CONTROL):
			dashing =true
			$AnimationPlayer.play("roullade")
			var timer=Timer.new()
			timer.set_wait_time(1.302)# time of animation
			add_child(timer)
			timer.start()
			actual = 0
			previous =0
			yield(timer, "timeout")
			timer.queue_free()
			dashing = false
	else:
		actual = actual + delta
		if(actual - previous > 0.01):
			previous = actual
			if(self.scale.x>0):
				position.x += speed * delta * 2.8
			else:
				position.x -= speed * delta * 2.8
	
	
