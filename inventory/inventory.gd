extends Resource
class_name Inv

@export var slots: Array[InvSlot]

signal item_inserted(item: InvItem, amount: int)

func insert(item: InvItem, amount: int = 1) -> bool:
	for slot in slots:
		if slot.item != null and slot.item == item:
			slot.amount += amount
			emit_signal("item_inserted", item, slot.amount)
			for i in slots:
				if i.item != null:
					print("Slot has:", i.item.name, "x", i.amount)
				else:
					print("Slot is empty")
			return true
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.amount = amount
			emit_signal("item_inserted", item, slot.amount)
			for i in slots:
				if i.item != null:
					print("Slot has:", i.item.name, "x", i.amount)
				else:
					print("Slot is empty")
			return true
	return false

func remove(item: InvItem, amount: int = 1) -> bool:
	for slot in slots:
		if slot.item == item:
			slot.amount -= amount
			if slot.amount <= 0:
				slot.item = null
				slot.amount = 0
			return true
	return false
