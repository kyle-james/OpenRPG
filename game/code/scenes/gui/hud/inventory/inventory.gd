extends GridContainer;
const ItemClass = preload("item.gd");
const ItemSlotClass = preload("itemSlot.gd");

var list = preload("res://code/scenes/util/JSONHandler.gd").new()

const slotTexture = preload("res://assets/textures/gui/inventory/tile.png");

var slotList = Array();
var itemList = Array();

var holdingItem = null;

func _ready():
	list.loadItemSets();
	var itemDictionary = list.itemDictionary
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon:Texture = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		var itemSource = itemDictionary[item].itemSource;
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSource));
	
	for i in range(20):
		var slot = ItemSlotClass.new(i);
		slotList.append(slot);
		add_child(slot);
	for j in range(len(itemList)):
		slotList[j].setItem(itemList[j]);
	
	pass

func _input(event):
	if holdingItem != null && holdingItem.picked:
		holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot;
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			if isClicked:
				clickedSlot = slot;
		
		if holdingItem == null and clickedSlot == null:
			return;
		
		if clickedSlot == null:
			return;
			
		if holdingItem != null and clickedSlot != null:
			if clickedSlot.item != null:
				var tempItem = clickedSlot.item;
				var oldSlot = slotList[slotList.find(holdingItem.itemSlot)];
				clickedSlot.pickItem();
				clickedSlot.putItem(holdingItem);
				holdingItem = null;
				oldSlot.putItem(tempItem);
			else:
				clickedSlot.putItem(holdingItem);
				holdingItem = null;
		elif clickedSlot.item != null:
			holdingItem = clickedSlot.item;
			clickedSlot.pickItem();
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
	pass
