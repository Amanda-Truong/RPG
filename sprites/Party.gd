
export var size : int = 4

var invent = Inventory.new()

func getMembers() -> Array:
	var members = []
	for member in get_children():
		if member.visible:
			members.append(member)
	return members
