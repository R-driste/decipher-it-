extends CharacterBody2D

const SPEED := 130.0
const JUMP_VELOCITY := 300.0
const GRAVITY := 800.0

var tilemap: TileMap
var is_jumping := false
var vertical_velocity := 0.0
var jump_start_position := Vector2.ZERO

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

func is_position_walkable(pos: Vector2) -> bool:
	var cell := tilemap.local_to_map(pos)
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
		var input_vector := Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		var next_pos := global_position + input_vector * SPEED * delta
		if is_position_walkable(next_pos):
			velocity.x = input_vector.x * SPEED
			velocity.y = input_vector.y * SPEED
		else:
			velocity = Vector2.ZERO

		if input_vector.length() > 0:
			if step_sound and not step_sound.playing:
				step_sound.play()
		else:
			if step_sound:
				step_sound.stop()

		# Start jump
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			jump_start_position = global_position
			vertical_velocity = JUMP_VELOCITY
			velocity.x = 0
			velocity.y = 0
			if jump_sound:
				jump_sound.play()

	move_and_slide()
