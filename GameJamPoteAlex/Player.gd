extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

export var speed = 40

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		# Move as long as the key/button is pressed.
		position.x += speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
