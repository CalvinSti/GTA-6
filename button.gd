extends Button

func _ready():
	pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("main_menu.tscn")
	Levels.score = 0
	Levels.level = 1
