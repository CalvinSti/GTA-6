extends Area2D

@export var lifetime: float = 2.5  # Time before disappearing
signal target_expired  # Signal to notify game over

func _ready():
	randomize_position()
	start_lifetime_timer()

func randomize_position():
	var viewport_size = get_viewport_rect().size
	var new_x = randf_range(50, viewport_size.x - 50)
	var new_y = randf_range(50, viewport_size.y - 50)
	global_position = Vector2(new_x, new_y)

func start_lifetime_timer():
	await get_tree().create_timer(lifetime).timeout
	emit_signal("target_expired")
	queue_free()
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()
		Rscore.addPoints(1)
