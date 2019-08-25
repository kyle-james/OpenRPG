extends Node2D

var width = 16; var height = 16;
var grid = [];
var rand_grid = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, width): #standard array stuff
		grid.append([])
		rand_grid.append([])
		for j in range(0, height):
			grid[i].append(-2)
			rand_grid[i].append(-2)
			j = j #this literally does nothing but stop the debugger from telling me it's not used.

	for i in range(0, width): #builds a 16x16 mini map
		for j in range(0, height):
			grid[i][j] = 2
			get_node("TileMap").set_cell(i, j, 2)

	for i in range(0, width): #this randomly generates the map/dungeon
		for j in range(0, height):
			randomize()
			rand_grid[i][j] = floor(rand_range(1, 4)) #places rooms if random # lands on 1
			if rand_grid[i][j] == 1:
					get_node("TileMap").set_cell(i, j, 0) #sets minimap to tile 0
					grid[i][j] = 0 #makes grid value 0

	for i in range(0, width): #creates hallways
		for j in range(0, height):
			if grid[i][j] == 0: pass
			else:
				if (i < width - 1):
					if(grid[i+1][j] == 0 and grid[i][j-1] == 0): #if there's a gap between diagonal (TR and LC) rooms, this adds a hallway
						grid[i][j] = 130
						get_node("TileMap").set_cell(i, j, 1)

#					if (grid[i-1][j] == 1 and grid[i+1][j] == 1): #if there's a single gap between 2 horizontal HALLWAYS, this adds another 
#						grid[i][j] = 1
#						get_node("TileMap").set_cell(i, j, 1)

				if (j < height -1):
					if(grid[i-1][j] == 0 and grid[i][j+1] == 0): #if there's a gap between diagonal (TL and BR) rooms, this adds a hallway
						grid[i][j] = 1
						get_node("TileMap").set_cell(i, j, 1)

#					if(grid[i][j-1] == 1 and grid[i][j+1] == 1): #if there's a single gap between 2 vertical HALLWAYS, this adds another
#						grid[i][j] = 1
#						get_node("TileMap").set_cell(i, j, 1)

				if (i < width - 1) and (j < height - 1):
					if (grid[i+1][j] == 0 and grid[i][j+1] == 0): #if there's a gap between diagonal (RC and BC) rooms, this adds a hallway
						grid[i][j] = 110
						get_node("TileMap").set_cell(i, j, 1)

					if(grid[i-1][j] == 0 and grid[i][j-1] == 0): #if there's a gap between diagonal (TC and LC) rooms, this adds a hallway
						grid[i][j] = 120
						get_node("TileMap").set_cell(i, j, 1)

				if (i < width - 1):
					if(grid[i-1][j] == 0 and grid[i+1][j] == 0): #if there's a single gap between 2 horizontal rooms, this adds a hallway
						grid[i][j] = 100
						get_node("TileMap").set_cell(i, j, 1)

				if (j < height -1):
					if(grid[i][j-1] == 0 and grid[i][j+1] == 0): #if there's a single gap between 2 vertical rooms, this adds a hallway
						grid[i][j] = 200
						get_node("TileMap").set_cell(i, j, 1)

	for i in range(0, width): #this part generates the actual map that will be played on.
		for j in range(0, height):
			if grid[i][j] == 0: #this part builds all grid[i][j] with value of 0 into 16x16 squares. basically floor layout
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 0)

			if grid[i][j] == 1: #this part builds all grid[i][j] with value of 1 into 16x16 squares.
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 2: #this part finds all grid[i][j] with a value of 2 and fills it with a void tile
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 2)

			if grid[i][j] == 100: #this is the horizontal hallway generation - COMPLETE
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						if (ja == j * height + 4) or (ja == j * height + 11):
							get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							if (ja == j * height + k):
								get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 110: #this is the RC AND BC hallway generation - COMPLETE
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(4, 16):
							if (ia == i * width + 4 and ja == j * height + k) or (ia == i * width + 11 and ja == j * height + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(4, 16):
							if (ja == j * height + 4 and ia == i * width + k) or (ja == j * height + 11 and ia == i * width + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							for l in range(5, 16):
								if (ja == j * height + k and ia == i * width + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
								if (ia == i * width + k and ja == j * height + l):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 120: #this is the TC AND LC hallway generation - COMPLETE
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(0, 12):
							if (ia == i * width + 4 and ja == j * height + k) or (ia == i * width + 11 and ja == j * height + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(0, 12):
							if (ja == j * height + 4 and ia == i * width + k) or (ja == j * height + 11 and ia == i * width + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							for l in range(0, 11):
								if (ja == j * height + k and ia == i * width + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
								if (ia == i * width + k and ja == j * height + l):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 130: #this is the TC AND RC hallway generation - COMPLETE
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(0, 12):
							if (ia == i * width + 4 and ja == j * height + k) or (ia == i * width + 11 and ja == j * height + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(4, 16):
							if (ja == j * height + 4 and ia == i * width + k) or (ja == j * height + 11 and ia == i * width + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							for l in range(5, 16):
								if (ja == j * height + k and ia == i * width + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
						for k in range(5, 11):
							for l in range(0, 5):
								if (ja == j * height + l and ia == i * width + k):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 200: #this is the vertical hallway generation - COMPLETE
				for ia in range(i * width, i * width + width):
					for ja in range(j * height, j * height + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						if (ia == i * width + 4) or (ia == i * width + 11):
							get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							if (ia == i * width + k):
								get_node("Dungeon").set_cell(ia, ja, 1)
	pass
#       _                                    _                 _                _             __ _                                  _ _  __       _             
#      | |                                  (_)               | |              | |           / _| |                                | (_)/ _|     (_)            
#   ___| |__   __ _ _ __   __ _  ___  __   ___  _____      __ | |__   __ _  ___| | __   __ _| |_| |_ ___ _ __   _ __ ___   ___   __| |_| |_ _   _ _ _ __   __ _ 
#  / __| '_ \ / _` | '_ \ / _` |/ _ \ \ \ / / |/ _ \ \ /\ / / | '_ \ / _` |/ __| |/ /  / _` |  _| __/ _ \ '__| | '_ ` _ \ / _ \ / _` | |  _| | | | | '_ \ / _` |
# | (__| | | | (_| | | | | (_| |  __/  \ V /| |  __/\ V  V /  | |_) | (_| | (__|   <  | (_| | | | ||  __/ |    | | | | | | (_) | (_| | | | | |_| | | | | | (_| |
#  \___|_| |_|\__,_|_| |_|\__, |\___|   \_/ |_|\___| \_/\_/   |_.__/ \__,_|\___|_|\_\  \__,_|_|  \__\___|_|    |_| |_| |_|\___/ \__,_|_|_|  \__, |_|_| |_|\__, |
#                          __/ |                                                                                                             __/ |         __/ |
#                         |___/                                                                                                             |___/         |___/ 