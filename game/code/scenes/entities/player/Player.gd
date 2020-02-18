extends Node2D

func get_input(): #this code is available from the official Godot docs, under 2d movement. It's a simple 8-way movement.
	if Input.is_action_just_pressed('torch'):
		if $KinematicBody2D.torch == false:
			$PlayerBody/Light2D.enabled = true
			$PlayerBody.torch = true
		else:
			$PlayerBody/Light2D.enabled = false
			$PlayerBody.torch = false
#	if Input.is_action_just_pressed("save"):
#		get_node("JSONHandler").generateItemList()

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	if Input.is_action_just_pressed("home"):
		get_tree().change_scene("res://code/scenes/world/world.tscn")

	if Input.is_action_just_pressed("bag"):
		if $PlayerBody.bag == false:
			$PlayerBody.bag = true
			$PlayerBody/Camera2D/HUD/Inventory/Panel.show()
		else:
			$PlayerBody.bag = false
			$PlayerBody/Camera2D/HUD/Inventory/Panel.hide()

	if Input.is_action_just_pressed("journal"):
		if $PlayerBody.journal == false:
			$PlayerBody.journal = true
			$PlayerBody/Camera2D/HUD/Journal/Panel.show()
			$PlayerBody/Camera2D/HUD/Journal/Panel/TextEdit.grab_focus()
		else:
			$PlayerBody.journal = false
			$PlayerBody/Camera2D/HUD/Journal/Panel.hide()
			$PlayerBody/Camera2D/HUD/Journal/Panel/TextEdit.release_focus()

# warning-ignore:unused_argument
func _physics_process(delta): #this allows for the input to be processed as physics.
	if $PlayerBody/Camera2D/HUD/Journal.focused == true:
		
		pass
	if $PlayerBody/Camera2D/HUD/Journal.focused == false:
		get_input()
		$PlayerBody.velocity = $PlayerBody.move_and_slide($PlayerBody.velocity)
