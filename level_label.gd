extends Label

func _ready():
	# Hide LevelLabel by default
	visible = false
	call_deferred("update_visibility")  # Ensure the scene is fully loaded before checking

func update_visibility():
	await get_tree().process_frame  # Ensure the scene is fully loaded
	var current_scene = get_tree().current_scene

	if current_scene:
		print("Current scene name: ", current_scene.name)  # Debugging log
		if current_scene.name == "Game1":  
			visible = true  # Make visible in Game1
		else:
			visible = false  # Hide in all other scenes
