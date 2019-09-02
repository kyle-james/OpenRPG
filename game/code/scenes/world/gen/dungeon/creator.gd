extends Node2D

var width = 18; var height = 18;
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

	for i in range(0, width): #builds a 18x18 mini map of void tiles. the extra 2x2 is for easier generation due to array restrictions.
		for j in range(0, height):
			grid[i][j] = 0
			get_node("TileMap").set_cell(i, j, 2)

	for i in range(1, width - 1): #this randomly generates the map/dungeon
		for j in range(1, height - 1):
			if(i == 1 and j == 1): #this guarentees the top left grid space is always a valid room.
				grid[i][j] = 1
				get_node("TileMap").set_cell(i, j, 0)
			randomize() # on every load, it randomizes the outcome
			rand_grid[i][j] = floor(rand_range(1, 4)) #places rooms if random # lands on 1
			if rand_grid[i][j] == 1: 
					get_node("TileMap").set_cell(i, j, 0) #sets minimap to tile 0
					grid[i][j] = 1 #makes grid value 1

	for i in range(1, width - 1): #creates hallways
		for j in range(1, height - 1):
			if grid[i][j] == 1: pass #if the current grid value is 1, it means there's a room there. don't want to put a hallway in a room
			else:
				if(grid[i+1][j] == 1 and grid[i][j-1] == 1): #if there's a gap between diagonal (TR and LC) rooms, this adds a hallway
					grid[i][j] = 130
					get_node("TileMap").set_cell(i, j, 1)

#					if (grid[i-1][j] == 1 and grid[i+1][j] == 1): #if there's a single gap between 2 horizontal HALLWAYS, this adds another 
#						grid[i][j] = 1
#						get_node("TileMap").set_cell(i, j, 1)

				if(grid[i-1][j] == 1 and grid[i][j+1] == 1): #if there's a gap between diagonal (TL and BR) rooms, this adds a hallway
					grid[i][j] = 140
					get_node("TileMap").set_cell(i, j, 1)

#					if(grid[i][j-1] == 1 and grid[i][j+1] == 1): #if there's a single gap between 2 vertical HALLWAYS, this adds another
#						grid[i][j] = 1
#						get_node("TileMap").set_cell(i, j, 1)

				if (grid[i+1][j] == 1 and grid[i][j+1] == 1): #if there's a gap between diagonal (RC and BC) rooms, this adds a hallway
					grid[i][j] = 110
					get_node("TileMap").set_cell(i, j, 1)

				if(grid[i-1][j] == 1 and grid[i][j-1] == 1): #if there's a gap between diagonal (TC and LC) rooms, this adds a hallway
					grid[i][j] = 120
					get_node("TileMap").set_cell(i, j, 1)

				if(grid[i-1][j] == 1 and grid[i+1][j] == 1): #if there's a single gap between 2 horizontal rooms, this adds a hallway
					grid[i][j] = 100
					get_node("TileMap").set_cell(i, j, 1)

				if(grid[i][j-1] == 1 and grid[i][j+1] == 1): #if there's a single gap between 2 vertical rooms, this adds a hallway
					grid[i][j] = 200
					get_node("TileMap").set_cell(i, j, 1)

	for i in range(1, width - 1): #this part generates the actual map that will be played on.
		for j in range(1, height - 1):
			var mapI = i * (width - 2);
			var mapJ = j * (height - 2); #these variables fix the 18x18 grid issue, allowing checking out of array bounds

			if grid[i][j] == 0: #this part finds all grid[i][j] with a value of 2 and fills the real map with a 16x16 void 'room'
				for ia in range(mapI, mapI + (width - 2)):
					for ja in range(mapJ, mapJ + (height - 2)):
						get_node("Dungeon").set_cell(ia, ja, 2)

			if grid[i][j] == 1: #this part builds all grid[i][j] with value of 1 into 16x16 squares of stone bricks. basically floor layout
				for ia in range(mapI, mapI + (width - 2)):
					for ja in range(mapJ, mapJ + (height - 2)):
						get_node("Dungeon").set_cell(ia, ja, 0)

						if(ia == mapI): #this part checks and builds the correct walls on the left side of rooms
							if(grid[i-1][j] == 0): #if there's void to the left, it makes the leftmost collum stone walls
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i-1][j] > 99): #if there's a hallway on the left, it creates a wall in the leftmost collum, but leaves 6 tiles open for the hallway
								for k in range(0, 5):
									if(ja == mapJ + k):
										get_node("Dungeon").set_cell(ia, ja, 3)
								for k in range(11, 16):
									if(ja == mapJ + k):
										get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i-1][j] == 200): #if there's a vertical straight to the left, it makes sure it doesn't open up the wall
								get_node("Dungeon").set_cell(ia, ja, 3)

						if(ia == mapI + (width - 3)): #this part checks and builds the correct walls on the right side of rooms
							if(grid[i+1][j] == 0): #if there's void on the right, it makes the rightmost collum stone walls
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i+1][j] > 99): #if there's a hallway on the right, it creates a wall in the rightmost collum, but leaves 6 tiles open for the hallway
								for k in range(0, 5):
									if(ja == mapJ + k):
										get_node("Dungeon").set_cell(ia, ja, 3)
								for k in range(11, 16):
									if(ja == mapJ + k):
										get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i+1][j] == 200): #if there's a vertical straight to the right, it makes sure it doesn't open up the wall
								get_node("Dungeon").set_cell(ia, ja, 3)

						if(ja == mapJ): #this part checks and builds the correct walls on the top side of rooms
							if(grid[i][j-1] == 0): #if there's void to the top, it makes the topmost collum stone walls
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i][j-1] > 99): #if there's a hallway oto the top, it creates a wall in the topmost collum, but leaves 6 tiles open for the hallway
								for k in range(0, 5):
									if(ia == mapI + k):
										get_node("Dungeon").set_cell(ia, ja, 3)
								for k in range(11, 16):
									if(ia == mapI + k):
										get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i][j-1] == 100): #if there's a horizontal straight to the top, it makes sure it doesn't open up the wall
								get_node("Dungeon").set_cell(ia, ja, 3)

						if(ja == mapJ + (height - 3)): #this part checks and builds the correct walls on the bottom side of rooms
							if(grid[i][j+1] == 0): #if there's void to the bottom, it makes the bottommost collum stone walls
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i][j+1] > 99): #if there's a hallway to the bottom, it creates a wall in the bottommost collum, but leaves 6 tiles open for the hallway
								for k in range(0, 5):
									if(ia == mapI + k):
										get_node("Dungeon").set_cell(ia, ja, 3)
								for k in range(11, 16):
									if(ia == mapI + k):
										get_node("Dungeon").set_cell(ia, ja, 3)
				
							if(grid[i][j+1] == 100): #if there's a horizontal striaght to the bottom, it makes sure it doesn't open up the wall
								get_node("Dungeon").set_cell(ia, ja, 3)

						if(ia == mapI) and (ja == mapJ): # if the current tile is in the top left
							if(grid[i-1][j] == 1) and (grid[i][j-1] == 1) and (grid[i-1][j-1] != 1): #if the chunk to the top and to the left are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i][j-1] == 1) and (grid[i-1][j] == 1) and (grid[i-1][j-1] != 1): #if the chunk to the left and to the top are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

						if(ia == mapI) and (ja == mapJ + (height - 3)): #if the current tile is in the bottom left
							if(grid[i-1][j] == 1) and (grid[i][j+1] == 1) and (grid[i-1][j+1] != 1): #if the chunk to the bottom anf to the left are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i-1][j] == 1) and (grid[i][j+1] == 1) and (grid[i-1][j+1] != 1): #if the chunk to the left and to the bottom are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

						if(ia == mapI + (width - 3)) and (ja == mapJ): #if the current tile is in the top right
							if(grid[i+1][j] == 1) and (grid[i][j-1] == 1) and (grid[i+1][j-1] != 1): #if the chunk to the left and to the bottom are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

#							if(grid[i+1][j] == 1) and (grid[i][j-1] == 1) and (grid[i+1][j-1] != 1): #if the chunk to the bottom and to the left are rooms, place a wall
#								get_node("Dungeon").set_cell(ia, ja, 2)

						if(ia == mapI + (width - 3)) and (ja == mapJ + (height - 3)): #if the current tile is in the bottom right
							if(grid[i+1][j] == 1) and (grid[i][j+1] == 1) and (grid[i+1][j+1] != 1): #if the chunk to the bottom and to the right are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

							if(grid[i][j+1] == 1) and (grid[i+1][j] == 1) and (grid[i+1][j+1] != 1): #if the chunk to the right and to the bottom are rooms, place a wall
								get_node("Dungeon").set_cell(ia, ja, 3)

#			if grid[i][j] == 2: #this part builds all grid[i][j] with value of 2 into 16x16 squares of light stone bricks.
#				for ia in range(mapI, mapI + width):
#					for ja in range(mapJ, mapJ + height):
#						get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 100: #this is the horizontal hallway generation - COMPLETE ####TODO - comment better ####
				for ia in range(mapI, mapI + width):
					for ja in range(mapJ, mapJ + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						if (ja == mapJ + 4) or (ja == mapJ + 11):
							get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							if (ja == mapJ + k):
								get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 110: #this is the RC AND BC hallway generation - COMPLETE ####TODO - comment better ####
				for ia in range(mapI, mapI + width):
					for ja in range(mapJ, mapJ + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(4, 16):
							if (ia == mapI + 4 and ja == mapJ + k) or (ia == mapI + 11 and ja == mapJ + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(4, 16):
							if (ja == mapJ + 4 and ia == mapI + k) or (ja == mapJ + 11 and ia == mapI + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							for l in range(5, 16):
								if (ja == mapJ + k and ia == mapI + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
								if (ia == mapI + k and ja == mapJ + l):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 120: #this is the TC AND LC hallway generation - COMPLETE ####TODO - comment better ####
				for ia in range(mapI, mapI + width):
					for ja in range(mapJ, mapJ + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(0, 12):
							if (ia == mapI + 4 and ja == mapJ + k) or (ia == mapI + 11 and ja == mapJ + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(0, 12):
							if (ja == mapJ + 4 and ia == mapI + k) or (ja == mapJ + 11 and ia == mapI + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							for l in range(0, 11):
								if (ja == mapJ + k and ia == mapI + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
								if (ia == mapI + k and ja == mapJ + l):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 130: #this is the TC AND RC hallway generation - COMPLETE ####TODO - comment better ####
				for ia in range(mapI, mapI + width):
					for ja in range(mapJ, mapJ + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(0, 12):
							if (ia == mapI + 4 and ja == mapJ + k) or (ia == mapI + 11 and ja == mapJ + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(4, 16):
							if (ja == mapJ + 4 and ia == mapI + k) or (ja == mapJ + 11 and ia == mapI + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							for l in range(5, 16):
								if (ja == mapJ + k and ia == mapI + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
						for k in range(5, 11):
							for l in range(0, 5):
								if (ja == mapJ + l and ia == mapI + k):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 140: #this is the LC AND BC hallway generation - COMPLETE ####TODO - comment better ####
				for ia in range(mapI, mapI + width):
					for ja in range(mapJ, mapJ + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						for k in range(4, 16):
							if (ia == mapI + 4 and ja == mapJ + k) or (ia == mapI + 11 and ja == mapJ + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(0, 12):
							if (ja == mapJ + 4 and ia == mapI + k) or (ja == mapJ + 11 and ia == mapI + k):
								get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 16):
							for l in range(5, 11):
								if (ja == mapJ + k and ia == mapI + l):
									get_node("Dungeon").set_cell(ia, ja, 1)
						for k in range(0, 11):
							for l in range(5, 11):
								if (ja == mapJ + l and ia == mapI + k):
									get_node("Dungeon").set_cell(ia, ja, 1)

			if grid[i][j] == 200: #this is the vertical hallway generation - COMPLETE ####TODO - comment better ####
				for ia in range(mapI, mapI + width):
					for ja in range(mapJ, mapJ + height):
						get_node("Dungeon").set_cell(ia, ja, 2)
						if (ia == mapI + 4) or (ia == mapI + 11):
							get_node("Dungeon").set_cell(ia, ja, 4)
						for k in range(5, 11):
							if (ia == mapI + k):
								get_node("Dungeon").set_cell(ia, ja, 1)

	for i in range(0, width): #this part generates the void tiles surrounding the generated map
		for j in range(0, height):
			var mapI = i * (width - 2);
			var mapJ = j * (height - 2);

			if grid[i][j] == 0: #this part finds all grid[i][j] with a value of 2 and fills it with a void tile
				for ia in range(mapI, mapI + (width - 2)):
					for ja in range(mapJ, mapJ + (height - 2)):
						get_node("Dungeon").set_cell(ia, ja, 2)

#       _                                    _                 _                _             __ _                                  _ _  __       _             
#      | |                                  (_)               | |              | |           / _| |                                | (_)/ _|     (_)            
#   ___| |__   __ _ _ __   __ _  ___  __   ___  _____      __ | |__   __ _  ___| | __   __ _| |_| |_ ___ _ __   _ __ ___   ___   __| |_| |_ _   _ _ _ __   __ _ 
#  / __| '_ \ / _` | '_ \ / _` |/ _ \ \ \ / / |/ _ \ \ /\ / / | '_ \ / _` |/ __| |/ /  / _` |  _| __/ _ \ '__| | '_ ` _ \ / _ \ / _` | |  _| | | | | '_ \ / _` |
# | (__| | | | (_| | | | | (_| |  __/  \ V /| |  __/\ V  V /  | |_) | (_| | (__|   <  | (_| | | | ||  __/ |    | | | | | | (_) | (_| | | | | |_| | | | | | (_| |
#  \___|_| |_|\__,_|_| |_|\__, |\___|   \_/ |_|\___| \_/\_/   |_.__/ \__,_|\___|_|\_\  \__,_|_|  \__\___|_|    |_| |_| |_|\___/ \__,_|_|_|  \__, |_|_| |_|\__, |
#                          __/ |                                                                                                             __/ |         __/ |
#                         |___/                                                                                                             |___/         |___/ 