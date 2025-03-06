extends Control

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	Levels.score = 0
	Levels.level = 1
	Sscore.score = 0
	Rscore.score = 0


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("main_menu.tscn")
	Levels.score = 0
	Levels.level = 1
	Sscore.score = 0
	Rscore.score = 0
	
