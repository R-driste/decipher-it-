extends Area2D

@export var item_name: String = "Book2"
@export var glow_distance: float = 50
@export var glow_speed: float = 5.0

@onready var sprite: Sprite2D = $Sprite2D
var player_in_range: bool = false
var time: float = 0.0

func _ready():
	monitoring = true
	set_process_input(true)  # enable _input processing

func _process(delta: float) -> void:
	var player = get_parent().get_node("Dristi")
	if player:
		var distance = global_position.distance_to(player.global_position)
		player_in_range = distance <= glow_distance

		if player_in_range:
			time += delta
			var pulse = 0.5 + 0.5 * sin(time * glow_speed * PI)
			sprite.modulate = Color(1, 1, 0.0) * (1 + pulse)
		else:
			sprite.modulate = Color(1, 1, 1, 1)
			time = 0.0

func _input(event: InputEvent) -> void:
	if player_in_range and event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			var player = get_parent().get_node("Dristi")
			if player:
				player.add_item(item_name)
				print("Picked up:", item_name)
				queue_free()
