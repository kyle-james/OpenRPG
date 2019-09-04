extends KinematicBody2D

var speed = 400 #CHANGE BACK TO 200

var velocity = Vector2()

const playerSprites = [
	preload("res://assets/textures/entities/player_front.png"),
	preload("res://assets/textures/entities/player_back.png"),
	preload("res://assets/textures/entities/player_left.png"),
	preload("res://assets/textures/entities/player_right.png")
]
#this is cause i'm testing ita

func get_input(): #this code is available from the official Godot docs, under 2d movement. It's a simple 8-way movement.
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
		$PlayerTexture.texture = playerSprites[3]
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		$PlayerTexture.texture = playerSprites[2]
	if Input.is_action_pressed('down'):
		velocity.y += 1
		$PlayerTexture.texture = playerSprites[0]
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		$PlayerTexture.texture = playerSprites[1]
	if Input.is_action_pressed('sprint'):
		speed = 700
	if Input.is_action_just_released('sprint'):
		speed = 400 #CHANG BACK TO 200
	velocity = velocity.normalized() * speed
	
#	if Input.is_action_just_pressed("save"):
#		get_node("Camera2D/Control/Inventory").generateItemList()

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("home"):
		
		get_tree().change_scene("res://code/scenes/world/world.tscn")
# warning-ignore:unused_argument
func _physics_process(delta): #this allows for the input to be processed as physics.
	get_input()
	velocity = move_and_slide(velocity)