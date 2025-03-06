extends Node2D

var enemy_scene = preload("dogattack_right.tscn")  # Load the enemy scene

func _ready():
	$Timer.timeout.connect(spawn_enemy) 
	randomize_spawn_time() 

func spawn_enemy():
	var enemy = enemy_scene.instantiate() 
	var viewport_rect = get_viewport_rect() 
	
	# Get the player's Y position
	var player = get_node_or_null("/root/Main/Player")  
	var spawn_y = viewport_rect.size.y / 2  
	if player:
		spawn_y = player.global_position.y  

   
	enemy.global_position = Vector2(viewport_rect.size.x + 50, spawn_y)

	get_parent().add_child(enemy)  

	randomize_spawn_time()

func randomize_spawn_time():
	$Timer.wait_time = randf_range(0.5, 4)  # Random interval between 1 and 3 seconds
	$Timer.start()
	
	
func _exit_tree():
	$Timer.stop()  # Stop the timer when this node is freed
