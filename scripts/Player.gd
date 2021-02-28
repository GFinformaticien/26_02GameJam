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

func _on_Health_health_changed(health):
	print("djozuhdoazhdoizajd")
	if(health <= 0):
		$AnimationPlayer.stop()
		# TODO: Play the die animation
		# $AnimationPlayer.play("roullade")


func _on_hitbox_player_body_entered(body):
	if(body.name == "hitbox"):
		$Health.take_damage(body.damage)
