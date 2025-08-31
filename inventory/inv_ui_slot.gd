extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display

func update(slot: InvSlot):
	if !slot:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.texture
		if slot.texture:
			var tex_size = slot.texture.get_size()
			var target_size = Vector2(16, 16)
			var scale_factor = min(target_size.x / tex_size.x, target_size.y / tex_size.y)
			item_visual.scale = Vector2.ONE * scale_factor
