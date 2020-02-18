extends TextureRect

#https://github.com/Oen44/Godot-Inventory/blob/master/Inventory.gd
var itemIcon;
var itemName;
var itemSlot;
var picked = false;

func _init(itemName, itemTexture, itemSlot, itemValue, itemSource):
	itemIcon = itemIcon
	name = itemName;
	self.itemName = itemName;
	texture = itemTexture;
	hint_tooltip = str("Name: ", itemName, "\nValue: ", itemValue, "\nResource Pack: ", itemSource)
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	itemValue = itemValue
	pass
	
func pickItem():
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	picked = true;
	pass
	
func putItem():
	rect_global_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;
	pass
