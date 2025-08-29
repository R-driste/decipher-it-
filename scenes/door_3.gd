extends Area2D

@export var door_number: int = 3

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Dristi":  # assuming your player is named Dristi
		var ui = get_tree().get_current_scene().get_node("DoorUI/Control")
		if ui:
			ui.show_door_button(door_number)

func _on_body_exited(body):
	if body.name == "Dristi":
		var ui = get_tree().get_current_scene().get_node("DoorUI/Control")
		if ui:
			ui.hide_door_button()
