extends KinematicBody2D
#
var speed = 400
var torch = false;
var bag = false;
var journal = false;
var velocity = Vector2()
var health = 100;
var invincible = false;

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
		speed = 400
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed('torch'):
		if torch == false:
			$Light2D.enabled = true
			torch = true
		else:
			$Light2D.enabled = false
			torch = false
#	if Input.is_action_just_pressed("save"):
#		get_node("JSONHandler").generateItemList()

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("home"):
		get_tree().change_scene("res://code/scenes/world/world.tscn")

	if Input.is_action_just_pressed("bag"):
		if bag == false:
			bag = true
			$Camera2D/HUD/Inventory/Panel.show()
		else:
			bag = false
			$Camera2D/HUD/Inventory/Panel.hide()

#	if Input.is_action_just_pressed("journal"):
#		if journal == false:
#			journal = true
#			$Camera2D/HUD/Journal/Panel.show()
#			$Camera2D/HUD/Journal/Panel/TextEdit.grab_focus()
#		else:
#			journal = false
#			$Camera2D/HUD/Journal/Panel.hide()
#		#	$Camera2D/HUD/Journal/PanelL/TextEdit.

func _ready():
	$Camera2D/HUD/Health/HealthBar.max_value = health
	$Camera2D/HUD/Health/HealthBar.value = health
	$Camera2D/HUD/Health/HealthBar/HealthValue.text = str(health)

# warning-ignore:unused_argument
func _physics_process(delta): #this allows for the input to be processed as physics.
	if journal == true:
		if(Input.is_action_just_pressed("journal")):
			journal = false
			$Camera2D/HUD/Journal/Panel/TextEdit.release_focus()
			$Camera2D/HUD/Journal/Panel/TextEdit.hide()
		pass
	if journal == false:
		get_input()
		velocity = move_and_slide(velocity)

func PlayerHit():
	health -= 1
	$Camera2D/HUD/Health/HealthBar.value = health
	$Camera2D/HUD/Health/HealthBar/HealthValue.text = str(health)
	invincible = invincible
