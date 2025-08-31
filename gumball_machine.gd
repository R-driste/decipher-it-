extends Control

@export var description: String = "Insert a coin to get a paper."
@export var glow_color: Color = Color(0, 0.5, 1)
@export var normal_color: Color = Color(1, 1, 1)
@export var paper_item: InvItem

@onready var sprite: TextureRect = $TextureRect
@onready var popup_panel: Panel = $PopupPanel
@onready var popup_label: Label = $PopupPanel/Label

var selected: bool = false

func _ready():
	popup_panel.visible = false
	sprite.modulate = normal_color

func _on_click():
	selected = not selected
	sprite.modulate = glow_color if selected else normal_color
	popup_panel.visible = selected
	popup_label.text = description

func use_item(item_resource):
	if item_resource.name == "Coin":
		print("Dispensing paper!")
		var player = get_tree().get_current_scene().get_node("Dristi")
		player.inventory_yay.insert(paper_item)
		popup_label.text = "You got a paper with the safe code!"
	else:
		popup_label.text = "Nothing happens."
