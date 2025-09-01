extends Control
@onready var sprite = $Sprite2D
@onready var area2d = $Area2D
@onready var popup = $PopupPanel
@onready var label = $PopupPanel/Label
@export var description: String = "A locked door.\nYou need a key to escape."
var selected: bool = false
signal interactable_selected(interactable)

func _ready():
	popup.visible = false
	area2d.input_event.connect(Callable(self, "_on_area2d_click"))

func _process(delta):
	sprite.modulate = Color(0.5, 0.5, 1, 1) if selected else Color(1, 1, 1, 1)

func _on_area2d_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		selected = !selected
		popup.visible = selected
		label.text = description if selected else ""
		
		if selected:
			print("SELECTED!", self)
			var player = get_tree().current_scene.get_node("Dristi")
			var inventory_ui = player.get_node("Inv_UI")
			inventory_ui._on_interactable_selected(self)

func use_item(item: InvItem):
	print(item.name)
	if item.name == "Key":
		print("YAY YOU ESCAPED!")
		popup.visible = false
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		print("This door requires a key to open!")
