extends Area2D

@export var speed: float = 500  # Speed of the projectile
var direction: Vector2 = Vector2.UP  # Default direction is UP

func _process(delta):
	position += direction * speed * delta  # Move the projectile

func _on_body_entered(body):
	queue_free()  # Destroy projectile on collision
	
	func _take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
