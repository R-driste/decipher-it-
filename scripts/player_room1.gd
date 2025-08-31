extends CharacterBody2D

const SPEED := 130.0
const JUMP_VELOCITY := 300.0
const GRAVITY := 800.0

var tilemap: TileMap
var is_jumping := false
var vertical_velocity := 0.0
var jump_start_position := Vector2.ZERO

@export var inventory_yay: Inv
@onready var step_sound: AudioStreamPlayer2D = $StepSound
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var bgm: AudioStreamPlayer2D = $BGM

func _ready() -> void:
	tilemap = get_parent().get_node("TileMap2")
	if step_sound:
		step_sound.stop()
		step_sound.pitch_scale = 2.0
	if bgm:
		bgm.play()
	inventory_yay.connect("item_inserted", Callable(self, "_on_item_inserted"))

func add_item(item: InvItem, amount: int = 1) -> void:
	inventory_yay.insert(item, amount)

func remove_item(item: InvItem, amount: int = 1) -> void:
	inventory_yay.remove(item, amount)

func has_item(item: InvItem, amount: int = 1) -> bool:
	for slot in inventory_yay.slots:
		if slot.item == item and slot.amount >= amount:
			return true
	return false

func list_items() -> void:
	for slot in inventory_yay.slots:
		if slot.item:
			print(slot.item.name, "x", slot.amount)

func is_position_walkable(pos: Vector2) -> bool:
	var local_pos := tilemap.to_local(pos)
	var cell := tilemap.local_to_map(local_pos)
	var tile_data := tilemap.get_cell_tile_data(0, cell)
	if tile_data == null:
		return false
	return tile_data.get_custom_data("walkable") == true

func _physics_process(delta: float) -> void:
	if is_jumping:
		vertical_velocity -= GRAVITY * delta
		global_position.y -= vertical_velocity * delta
		if vertical_velocity <= -JUMP_VELOCITY:
			global_position = jump_start_position
			is_jumping = false
			vertical_velocity = 0
	else:
		var input_vector := Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()

		var next_pos := global_position + input_vector * SPEED * delta
		if is_position_walkable(next_pos):
			velocity = input_vector * SPEED
		else:
			velocity = Vector2.ZERO

		if input_vector.length() > 0 and step_sound and not step_sound.playing:
			step_sound.play()
		elif step_sound:
			step_sound.stop()

		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			jump_start_position = global_position
			vertical_velocity = JUMP_VELOCITY
			velocity = Vector2.ZERO
			if jump_sound:
				jump_sound.play()

	move_and_slide()
