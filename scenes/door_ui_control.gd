extends Control

@onready var door_button := $DoorButton
var door_number := 0

func _ready():
	door_button.hide()
	door_button.pressed.connect(_on_DoorButton_pressed)

func show_door_button(door_number_in: int):
	door_number = door_number_in
	door_button.text = "Open Door " + str(door_number)
	door_button.show()

func hide_door_button():
	door_button.hide()

func _on_DoorButton_pressed():
	print("Opening door " + str(door_number) + "!")
	match door_number:
		1:
			get_tree().change_scene_to_file("res://scenes/room_1.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/room_2.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/room_3.tscn")
		_:
			print("No room assigned for this door.")
