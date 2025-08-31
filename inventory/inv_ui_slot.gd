extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_label: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot or slot.item == null:
		item_visual.visible = false
		amount_label.visible = false
	else:
		item_visual.visible = true
		amount_label.visible = true
		item_visual.texture = slot.item.texture
		amount_label.text = str(slot.amount)
		
		if slot.item.texture:
			var tex_size = slot.item.texture.get_size()
			var target_size = Vector2(16, 16)
			var scale_factor = min(target_size.x / tex_size.x, target_size.y / tex_size.y)
			item_visual.scale = Vector2.ONE * scale_factor
