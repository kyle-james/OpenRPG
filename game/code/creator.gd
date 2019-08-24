extends Node2D

var width = 32; var height = 32; var num_grass = 300; var density = 4; var minlength = 2; var maxlength = 4;
var grid = []; var dir = {0:Vector2(0,-1),1:Vector2(-1,0),2:Vector2(1,0),3:Vector2(0,1)}
var curr = Vector2(); var step = Vector2();
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
#	self.set_pos(Vector2(800,64))
	for i in range(0, width):
		grid.append([])
		for j in range(0, height):
			grid[i].append(-2)
	for i in range(0, width):
		for j in range(0, height):
			if grid[i][j] == -2: get_node("TileMap").set_cell(i,j,3)
			if i == 0 or j == 0 or i == width-1 or j == height-1:
				grid[i][j] = -1
				get_node("TileMap").set_cell(i,j,0)
	generate_map(minlength, maxlength, density, num_grass)
	pass

func grass_rock(curr, dirv, lena):
	for i in range(1, lena, 1):
		if grid[curr.x][curr.y] == -1: return -1
		get_node("TileMap").set_cell(curr.x, curr.y, 0)
		grid[curr.x][curr.y]
		curr = curr + dirv
		
func rand_coord_tile(density):
	step = Vector2(density + rand_range(0, width / density), density + rand_range(0, width / density))
	return step

func calculation_map(minlength, maxlength, density):
	randomize()
	rand_coord_tile(density)
	if grid[step.x][step.y] == -1: return -1
	var dirr = [0, 1, 2, 3]
	dirr = dirr[randi()%dirr.size()]
	var dirv = dir[dirr]
	var lena = rand_range(minlength, maxlength)
	lena = lena * density + 1
	grass_rock(step, dirv, lena)
	
func generate_map(minlength, maxlength, density, num_grass):
	for count in range(1, num_grass, 1):
		calculation_map(minlength, maxlength, density)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
