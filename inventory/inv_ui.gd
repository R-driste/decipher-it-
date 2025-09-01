extends Control
@onready var inv: Inv = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open: bool = false
var selected_interactable: Node = null

func _ready():
	inv.item_inserted.connect(_on_item_inserted)
	for slot_ui in slots:
		slot_ui.slot_pressed.connect(_on_slot_pressed)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _on_item_inserted(item: InvItem, amount: int) -> void:
	update_slots()

func _on_interactable_selected(interactable: Node) -> void:
	print("INTERACTABLE:", interactable)
	if selected_interactable == interactable:
		selected_interactable = null
	else:
		selected_interactable = interactable
	print("Selected interactable:", selected_interactable)

func _on_slot_pressed(inv_slot: InvSlot) -> void:
	print("SLOT PRESSED in UI:", inv_slot, selected_interactable) # Debug print
	if not inv_slot or not inv_slot.item:
		return
	if selected_interactable and selected_interactable.has_method("use_item"):
		selected_interactable.use_item(inv_slot.item)
		inv_slot.amount -= 1
		if inv_slot.amount <= 0:
			inv_slot.item = null
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
