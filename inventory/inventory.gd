extends Resource
class_name Inv

@export var slots: Array[InvSlot]

func insert(item: InvItem, amount: int = 1) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.amount += amount
			return true
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.amount = amount
			return true
	return false
