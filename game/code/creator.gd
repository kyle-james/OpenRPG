extends Node2D

var width = 18; var height = 18;
var grid = [];
var rand_grid = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, width):
		grid.append([])
		rand_grid.append([])
		for j in range(0, height):
			grid[i].append(-2)
			rand_grid[i].append(-2)
			j = j #this literally does nothing but stop the debugger from telling me it's not used.
	for i in range(0, width):
		for j in range(0, height):
			if grid[i][j] == -2: get_node("TileMap").set_cell(i, j, 3)
			if i == 0 or j == 0 or i == width-1 or j == height-1:
				grid[i][j] = -1
				get_node("TileMap").set_cell(i, j, 0)
			else:
				randomize()
				rand_grid[i][j] = floor(rand_range(1, 4))
				if rand_grid[i][j] == 1:
					grid[i][j] = rand_grid[i][j]
					if i > 0 and j > 0:
						if grid[i][j-1] == 1: pass
						elif grid[i-1][j] == 1: pass
						elif grid[i-1][j-1] == 1: pass
						elif grid[i-1][j+1] == 1: pass
						else: get_node("TileMap").set_cell(i, j, 1)
	pass
#       _                                    _                 _                _             __ _                                  _ _  __       _             
#      | |                                  (_)               | |              | |           / _| |                                | (_)/ _|     (_)            
#   ___| |__   __ _ _ __   __ _  ___  __   ___  _____      __ | |__   __ _  ___| | __   __ _| |_| |_ ___ _ __   _ __ ___   ___   __| |_| |_ _   _ _ _ __   __ _ 
#  / __| '_ \ / _` | '_ \ / _` |/ _ \ \ \ / / |/ _ \ \ /\ / / | '_ \ / _` |/ __| |/ /  / _` |  _| __/ _ \ '__| | '_ ` _ \ / _ \ / _` | |  _| | | | | '_ \ / _` |
# | (__| | | | (_| | | | | (_| |  __/  \ V /| |  __/\ V  V /  | |_) | (_| | (__|   <  | (_| | | | ||  __/ |    | | | | | | (_) | (_| | | | | |_| | | | | | (_| |
#  \___|_| |_|\__,_|_| |_|\__, |\___|   \_/ |_|\___| \_/\_/   |_.__/ \__,_|\___|_|\_\  \__,_|_|  \__\___|_|    |_| |_| |_|\___/ \__,_|_|_|  \__, |_|_| |_|\__, |
#                          __/ |                                                                                                             __/ |         __/ |
#                         |___/                                                                                                             |___/         |___/ 