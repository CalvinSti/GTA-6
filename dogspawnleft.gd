extends Node2D

var enemy_scene = preload("dogattackleft.tscn")  # Load the left-attack scene

func _ready():
	$Timer.timeout.connect(spawn_enemy)  # Call spawn_enemy() when timer runs out
	randomize_spawn_time()  # Start with a random time

func spawn_enemy():
	if !is_inside_tree():  # Prevent spawning if node is removed
		return

	var enemy = enemy_scene.instantiate()  # Create an enemy instance
	var viewport_rect = get_viewport_rect()  # Get screen size

	# Get player's Y position
	var player = get_node_or_null("/root/Main/Player")  # Adjust path if needed
	var spawn_y = viewport_rect.size.y / 2  # Default Y if player is missing
	if player:
		spawn_y = player.global_position.y  # Use player's current Y position

	# Set spawn position (off-screen to the left)
	enemy.global_position = Vector2(-50, spawn_y)

	get_parent().add_child(enemy)  # Add enemy to the scene

	# Randomize next spawn interval
	randomize_spawn_time()

func randomize_spawn_time():
	if !is_inside_tree():
		return
	$Timer.wait_time = randf_range(0.5, 4)  # Random interval between 1 and 3 seconds
	$Timer.start()

func _exit_tree():
	$Timer.stop()  # Stop the timer when this spawner is removed
