extends KinematicBody2D

var speed = 200 #CHANGE BACK TO 200

var velocity = Vector2()

const playerSprites = [
	preload("res://assets/textures/entities/player_front.png"),
	preload("res://assets/textures/entities/player_back.png"),
	preload("res://assets/textures/entities/player_left.png"),
	preload("res://assets/textures/entities/player_right.png")
]
onready var nav := get_parent().get_node("Navigation2D")
# warning-ignore:unused_argument

var path : PoolVector2Array
var target : Object 



func _physics_process(delta): #this allows for the input to be processed as physics.
#	get_input()
	if target != null:
		move_and_slide((path[1] - global_position).normalized() * speed)
		set_path()
	
func set_path():
	path = nav.get_simple_path(global_position, target.global_position)

func _on_Area2D_body_entered(body):
	print(body)
	if body.is_in_group("Living"):
		target = body
		set_path()
