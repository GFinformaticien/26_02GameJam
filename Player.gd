extends Node2D


var timel
var previoustime


# Called when the node enters the scene tree for the first time.
func _ready():
	previoustime = 0
	timel = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("ui_weak"):
		weak_attack()
	elif event.is_action_pressed("ui_strong"):
		strong_attack()

func weak_attack():
	print("Weak attack")
	pass

func strong_attack():
	print("Strong attack")
	pass

export var speed = 120

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		# Move as long as the key/button is pressed.
		self.scale.x = 3.1
		position.x += speed * delta
		#walk(delta)
	if Input.is_action_pressed("ui_left"):
		self.scale.x = - 3.1
		position.x -= speed * delta
		walk(delta)
func walk(delta):
	timel += delta
	if(timel - previoustime > 0.3):
		previoustime = timel
		$AnimationPlayer.play("Walk")
