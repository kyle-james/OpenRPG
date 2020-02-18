extends Node2D

var loader = preload("../../../code/scenes/util/JSONHandler.gd").new()
func _process(delta):
	if($Portal/Area2D.overlaps_body($Player/PlayerBody)):
		get_tree().change_scene("res://code/scenes/world/gen/dungeon/creator.tscn")

	if($Spike/Area2D.overlaps_body($Player/PlayerBody)):
		if($Player/PlayerBody.invincible == false):
			$Player/PlayerBody.PlayerHit()

	if($Player/PlayerBody.health <= 0):
		get_tree().reload_current_scene()

	delta = delta
func _ready():
	$Player/PlayerBody.health = 100
#	$Player/PlayerBody/Camera2D/HUD/Inventory/JSONHandler.loadItemSets()
	
	loader._ready()
