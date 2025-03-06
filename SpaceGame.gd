extends Node2D

var dog_right_scene = preload("dogattack_right.tscn")
var dog_left_scene = preload("dogattackleft.tscn")

func _ready():
	$Dogspawnright/Timer.timeout.connect(spawn_dog_right)
	$dogspawnleft/Timer.timeout.connect(spawn_dog_left)
	if has_node("/root/Levels"):
		get_node("/root/Levels/CanvasLayer").visible = false
	if has_node("/root/Sscore"):
		get_node("/root/Sscore/CanvasLayer").visible = true
	if has_node("/root/Rscore"):
		get_node("/root/Rscore/CanvasLayer").visible = false

func spawn_dog_right():
	for i in range(2):
		var dog = dog_right_scene.instantiate()
		var viewport_rect = get_viewport_rect()
		var spawn_y = get_random_y_position()
		dog.global_position = Vector2(viewport_rect.size.x + 50, spawn_y)  # Spawn off-screen right
		add_child(dog)
	

func spawn_dog_left():
	for i in range(2):
		var dog = dog_left_scene.instantiate()
		var spawn_y = get_random_y_position()
		dog.global_position = Vector2(-50, spawn_y)  # Spawn off-screen left
		add_child(dog)


func get_random_y_position():
	var viewport_rect = get_viewport_rect()
	return randf_range(60, viewport_rect.size.y - 60) 
