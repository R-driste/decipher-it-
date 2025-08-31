extends Panel

@onready var items_container: GridContainer = $GridContainer

var item_icons = {
	"Book": preload("res://assets/sprites/book.png"),
	"Book2": preload("res://assets/sprites/book.png")
}

const CELL_SIZE = Vector2(32, 32)
const GRID_COLUMNS = 4

func _ready():
	items_container.columns = GRID_COLUMNS
	items_container.custom_minimum_size = CELL_SIZE * GRID_COLUMNS

func update_inventory(inventory: Dictionary) -> void:
	for child in items_container.get_children():
		child.queue_free()

	var item_list = inventory.keys()
	
	for row in range(4):
		for col in range(GRID_COLUMNS):
			var index = row * GRID_COLUMNS + col
			var item_name = item_list[index] if index < item_list.size() else null

			var cell = Panel.new()
			cell.custom_minimum_size = CELL_SIZE
			items_container.add_child(cell)

			if item_name:
				var texture = item_icons.get(item_name, null)
				if texture:
					var vbox = VBoxContainer.new()
					vbox.size_flags_horizontal = Control.SIZE_FILL
					vbox.size_flags_vertical = Control.SIZE_FILL
					cell.add_child(vbox)

					var icon = TextureRect.new()
					icon.texture = texture
					icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
					icon.custom_minimum_size = Vector2(20, 20)
					vbox.add_child(icon)

					var label = Label.new()
					label.text = "x%s" % inventory[item_name]
					label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
					vbox.add_child(label)
