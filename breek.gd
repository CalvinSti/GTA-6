extends StaticBody2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func hit():
	
	Levels.addPoints(1)  # Increase score
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	
	var Brecksleft = get_tree().get_nodes_in_group("Brick")
	if Brecksleft.size() == 1:
		get_parent().get_node("balls").is_active = false
		await get_tree().create_timer(1).timeout
		Levels.level += 1
		get_tree().reload_current_scene()
		
	else:
		await get_tree().create_timer(1).timeout
		queue_free()
