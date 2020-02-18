extends Node

var path_itemSets = "user://game/load/itemSets.json"

var item_init = preload("res://code/scenes/gui/hud/inventory/item.gd")

var itemDictionary = {};
var itemIcons = {};

func _ready():
	var dir = Directory.new()
	if !dir.dir_exists("user://game/"):
		dir.open("user://")
		dir.make_dir_recursive("user://game/load/")
		dir.copy("res://assets/game/load/itemSets.json", "user://game/load/itemSets.json")
		
		dir.make_dir_recursive("user://game/content/datastates/")
	
		dir.copy("res://assets/game/content/itemList.json", "user://game/content/itemList.json")
		
		dir.make_dir_recursive("user://game/content/textures/entities/")
		dir.copy("res://assets/textures/entities/player_back.png", "user://game/content/textures/entities/player_back.png")
		dir.copy("res://assets/textures/entities/player_left.png", "user://game/content/textures/entities/player_left.png")
		dir.copy("res://assets/textures/entities/player_right.png", "user://game/content/textures/entities/player_right.png")
		dir.copy("res://assets/textures/entities/player_front.png", "user://game/content/textures/entities/player_front.png")
		
		dir.make_dir_recursive("user://game/content/textures/gui/hud/health/")
		dir.copy("res://assets/textures/gui/hud/health/health.png", "user://game/content/textures/gui/hud/health/health.png")
		dir.copy("res://assets/textures/gui/hud/health/health_fill.png", "user://game/content/textures/gui/hud/health/health_fill.png")
		dir.copy("res://assets/textures/gui/hud/health/health_over.png", "user://game/content/textures/gui/hud/health/health_over.png")
		
		dir.make_dir_recursive("user://game/content/textures/gui/inventory/")
		dir.copy("res://assets/textures/gui/inventory/tile.png", "user://game/content/textures/gui/inventory/tile.png")
		
		dir.make_dir_recursive("user://game/content/textures/items/weapons/swords/")
		dir.copy("res://assets/textures/items/weapons/swords/longboi.png", "user://game/content/textures/items/weapons/swords/longboi.png")
		dir.copy("res://assets/textures/items/weapons/swords/shortboi.png", "user://game/content/textures/items/weapons/swords/shortboi.png")
		dir.copy("res://assets/textures/items/weapons/swords/sword.png", "user://game/content/textures/items/weapons/swords/sword.png")
		
		
		dir.make_dir_recursive("user://game/content/textures/objects/hazards")
		dir.copy("res://assets/textures/objects/hazards/spike.png", "user://game/content/textures/objects/hazards/spike.png")
		dir.copy("res://assets/textures/objects/portal.png", "user://game/content/textures/objects/portal.png")
		
		dir.make_dir_recursive("user://game/content/textures/shaders/")
		dir.copy("res://assets/textures/shaders/torch.png", "user://game/content/textures/shaders/torch.png")
		
		dir.make_dir_recursive("user://game/content/textures/tiles/base/dirt-grass_border")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/000.png", "user://game/content/textures/tiles/base/dirt-grass_border/000.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/001.png", "user://game/content/textures/tiles/base/dirt-grass_border/001.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/002.png", "user://game/content/textures/tiles/base/dirt-grass_border/002.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/003.png", "user://game/content/textures/tiles/base/dirt-grass_border/003.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/004.png", "user://game/content/textures/tiles/base/dirt-grass_border/004.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/005.png", "user://game/content/textures/tiles/base/dirt-grass_border/005.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/006.png", "user://game/content/textures/tiles/base/dirt-grass_border/006.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/007.png", "user://game/content/textures/tiles/base/dirt-grass_border/007.png")
		dir.copy("res://assets/textures/tiles/base/dirt-grass_border/008.png", "user://game/content/textures/tiles/base/dirt-grass_border/008.png")
		
		dir.make_dir_recursive("user://game/content/textures/tiles/base/grass-dirt_border")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/000.png", "user://game/content/textures/tiles/base/grass-dirt_border/000.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/001.png", "user://game/content/textures/tiles/base/grass-dirt_border/001.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/002.png", "user://game/content/textures/tiles/base/grass-dirt_border/002.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/003.png", "user://game/content/textures/tiles/base/grass-dirt_border/003.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/004.png", "user://game/content/textures/tiles/base/grass-dirt_border/004.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/005.png", "user://game/content/textures/tiles/base/grass-dirt_border/005.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/006.png", "user://game/content/textures/tiles/base/grass-dirt_border/006.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/007.png", "user://game/content/textures/tiles/base/grass-dirt_border/007.png")
		dir.copy("res://assets/textures/tiles/base/grass-dirt_border/008.png", "user://game/content/textures/tiles/base/grass-dirt_border/008.png")
		
		dir.make_dir_recursive("user://game/content/textures/tiles/dungeon/")
		dir.copy("res://assets/textures/tiles/dungeon/light_stone_brick.png", "user://game/content/textures/tiles/dungeon/light_stone_brick.png")
		dir.copy("res://assets/textures/tiles/dungeon/light_stone_brick_wall.png", "user://game/content/textures/tiles/dungeon/light_stone_brick_wall.png")
		dir.copy("res://assets/textures/tiles/dungeon/stone_brick.png", "user://game/content/textures/tiles/dungeon/stone_brick.png")
		dir.copy("res://assets/textures/tiles/dungeon/stone_brick_wall.png", "user://game/content/textures/tiles/dungeon/stone_brick_wall.png")
		dir.copy("res://assets/textures/tiles/dungeon/void.png", "user://game/content/textures/tiles/dungeon/void.png")

		dir.make_dir_recursive("user://resourcepacks/Test")
		dir.copy("res://assets/resourcepacks/Test/itemList.json", "user://resourcepacks/Test/itemList.json")
		
		dir.make_dir_recursive("user://resourcepacks/CantherKi/graphics/shortswords")
		dir.copy("res://assets/resourcepacks/CantherKi/itemList.json", "user://resourcepacks/CantherKi/itemList.json")
		dir.copy("res://assets/resourcepacks/CantherKi/graphics/shortswords/dagger.png", "user://resourcepacks/CantherKi/graphics/shortswords/dagger.png")
func loadItemSets():
	var data_file = File.new()
	if data_file.open(path_itemSets, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		print("ERROR IN JSON")
	for set in data_parse.result:
		var count = data_parse.result;
		if data_parse.result[str(set)].loadSet == false:
			print ("[ITEM SET] Skipping: ", set)
		else:
			print ("[ITEM SET] Loading: ", set)
			generateItemList(data_parse.result[str(set)].path, set)
		count = count
		

func generateItemList(path, set):
	var data_file = File.new()
	if data_file.open(path, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	for child in data_parse.result:
		var count = data_parse.result;
		var itemName = data_parse.result[str(child)].name;
		var itemPrice = data_parse.result[str(child)].price;
		var itemType = data_parse.result[str(child)].type;
		itemIcons[child] = data_parse.result[str(child)].texture
		var itemEnabled = data_parse.result[str(child)].enabled
		itemType = itemType
		var image = Image.new()
		var err = image.load(itemIcons[child])
		if err != OK:
			pass
		var texture = ImageTexture.new()
		texture.create_from_image(image, 0)
		if(itemEnabled):
			itemDictionary[child] = {
				"itemName": str(itemName),
				"itemIcon": texture,
				"itemSlot": null,
				"itemValue": str(itemPrice),
				"itemSource": set
			}
			print("\t[ITEM] Loading: ", child)
		else:
			print("\t[ITEM] Skipping: ", child)
		count = count;
#	print(itemDictionary.values())
	return itemDictionary.values()
