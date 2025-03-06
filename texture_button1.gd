extends Button

func _ready():
	pressed.connect(_on_game1_button_pressed)

func _on_game1_button_pressed():
	get_tree().change_scene_to_file("Game1.tscn")
