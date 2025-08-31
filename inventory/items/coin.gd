extends Area2D

@export var item_resource: InvItem = preload("res://inventory/items/coin.tres")
@export var glow_distance: float = 50
@export var glow_speed: float = 5.0

@onready var sprite: Sprite2D = $Sprite2D

var player_in_range: bool = false
var time: float = 0.0

func _ready():
	monitoring = true
	self.input_event.connect(Callable(self, "_on_input_event"))

func _process(delta: float) -> void:
	var player = get_parent().get_node("Dristi")
	if player:
		var distance = global_position.distance_to(player.global_position)
		player_in_range = distance <= glow_distance

		if player_in_range:
			time += delta
			var pulse = 0.5 + 0.5 * sin(time * glow_speed * PI)
			sprite.modulate = Color(1, 1, 0) * (1 + pulse)
		else:
			sprite.modulate = Color(1, 1, 1, 1)
			time = 0.0

func _on_input_event(viewport, event, shape_idx):
	if not player_in_range:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var player = get_parent().get_node("Dristi")
		if player and item_resource:
			var inv = player.inventory_yay   # Inv resource attached to player
			if inv.insert(item_resource):
				print("Picked up:", item_resource.name, "and added to inventory.")
				queue_free()
			else:
				print("No space in inventory for:", item_resource.name)
