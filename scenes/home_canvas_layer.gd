extends Control

@onready var door_button := $DoorButton  # The Button node under this Control

func _ready():
	door_button.hide()  # Hide initially

# Call this when the player enters a door area
func show_door_button(door_number: int):
	door_button.text = "Open Door " + str(door_number)
	door_button.show()

# Call this when the player exits a door area
func hide_door_button():
	door_button.hide()

# Optional: connect the button's pressed signal
func _on_DoorButton_pressed():
	print("Opening door!")  # Replace with scene change or level logic
