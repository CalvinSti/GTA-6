extends Button

func _ready():
	pressed.connect(_on_game2_button_pressed)

func _on_game2_button_pressed():
	get_tree().change_scene_to_file("Game2.tscn")
