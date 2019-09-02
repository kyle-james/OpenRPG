extends Node

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables

var path_itemListMaster = "res://assets/datastates/itemList.json"
var path_itemList = "user://resourcepacks/.default/datastates/itemList.json"

func _ready():
	var dir = Directory.new()
	if !dir.dir_exists("user://resourcepacks"):
		dir.open("user://")
		dir.make_dir("user://resourcepacks/")
		dir.make_dir("user://resourcepacks/.default")
		dir.make_dir("user://resourcepacks/.default/datastates")
		dir.make_dir("user://resourcepacks/.default/textures")
		dir.copy("res://*", "user://")

#func generateItemList():
#	var data_file = File.new()
#	if data_file.open(path_itemList, File.READ) != OK:
#		return
#	var data_text = data_file.get_as_text()
#	data_file.close()
#	var data_parse = JSON.parse(data_text)
#	if data_parse.error != OK:
#		return
#	for child in (data_parse.result):
#		var count = data_parse.result;
#		var itemName = data_parse.result[str(child)].name;
#		var itemPrice = data_parse.result[str(child)].price;
#		var itemTexture = data_parse.result[str(child)].texture;
#		var itemDictionary = {
#			child: {
#				"itemName": str("\"" + itemName + "\""),
#				"itemValue": str(itemPrice),
#				"itemIcon": str("\"" + itemTexture + "\"")
#			}
#		};
#		print(itemDictionary)