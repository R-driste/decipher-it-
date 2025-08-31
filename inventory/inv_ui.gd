extends Control

@onready var inv: Inv = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	inv.item_inserted.connect(_on_item_inserted)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _on_item_inserted(item: InvItem, amount: int) -> void:
	print("UPDATES YAYAYAY")
	if item != null:
		print("Received item:", item.name, " | Amount:", amount)
	else:
		print("Received empty slot update, amount:", amount)
	update_slots()

func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
