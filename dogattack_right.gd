extends Area2D
class_name dog

var hp = 1

@export var speed: float = 100  # Adjust movement speed

func _process(delta):
	global_position.x -= speed * delta  # Move left across the screen

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # Remove when off-screen
	
	
func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is shiplayer:
		area.take_damage(1)
	if area is laser:
		Levels.addPoints(1)
	
