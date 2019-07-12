var invent = {}
signal itemChanged(item, amount)

func add(item: Item, amount: int = 1) -> void:
	if item in invent:
		invent[item] += amount
	else:
		invent[item] = 1 if item.unique else amount

func remove(item: Item, amount: int = 1):
	assert item in invent
	assert amount <= invent[item]

	invent[item] -= amount
	if invent[item] == 0:
		invent.erase(item)
		emit_signal("itemChanged", item, 0)
	else:
		emit_signal("itemChanged", item, invent[item])
	

func getHead() -> Array:
	var equipment: Array
	for item in invent.keys():
		if item is Head:
			equipment.append(item)
	return equipment

func getPant() -> Array:
	var equipment: Array
	for item in invent.keys():
		if item is Pant:
			equipment.append(item)
	return equipment

func getBoot() -> Array:
	var equipment: Array
	for item in invent.keys():
		if item is Boot:
			equipment.append(item)
	return equipment

func getWeapon() -> Array:
	var equipment: Array
	for item in invent.keys():
		if item is Weapon:
			equipment.append(item)
	return equipment
