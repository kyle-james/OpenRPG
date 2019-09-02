extends Node2D

func _process(delta):
	if($Portal/Area2D.overlaps_body($Player/PlayerBody)):
		get_tree().change_scene("res://code/scenes/world/gen/dungeon/creator.tscn")