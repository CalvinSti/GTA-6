extends Area2D
class_name laser

var speed = 150

func _physics_process(delta: float) -> void:
	global_position.y += -speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		area.take_damage(1)
		
