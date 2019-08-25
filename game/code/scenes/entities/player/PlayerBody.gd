extends KinematicBody2D

var speed = 2000 #CHANGE BACK TO 200

var velocity = Vector2()

func get_input(): #this code is available from the official Godot docs, under 2d movement. It's a simple 8-way movement.
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('sprint'):
		speed = 350
	if Input.is_action_just_released('sprint'):
		speed = 2000 #CHANG BACK TO 200
	velocity = velocity.normalized() * speed

func _physics_process(delta): #this allows for the input to be processed as physics.
	get_input()
	velocity = move_and_slide(velocity)