extends CharacterBody2D

func _process(delta):
	var viewport_rect = get_viewport_rect()  # Get the viewport boundaries
	var mouse_x = get_global_mouse_position().x

	# Clamp the position to stay within the window width
	global_position.x = clamp(mouse_x, 0, viewport_rect.size.x)
