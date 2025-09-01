extends Control

@onready var label = $Label

@export var rules_text: String = "Welcome to the game!\nRules (Only Door 1 is Available):\n- Press I to access inventory. \n- Select one interactive at a time \n- Go near objects and click to store them. \n- Once an object is used, its gone forever so careful.\nPress any key to start."
@export var win_text: String = "YAY! You escaped!"

func _ready():
	if GameState.first_open:
		label.text = rules_text
	else:
		label.text = win_text
	self.visible = true

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		self.visible = false
		GameState.first_open = false  # Only the first launch shows rules
