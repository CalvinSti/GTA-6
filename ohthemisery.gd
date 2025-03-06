extends Area2D

var hp = 1

func _ready() -> void:
	pass

var speed = 195

func _physics_process(delta):
	global_position.y += speed * delta
	

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is shiplayer:
		area.take_damage(1)
	if area is laser:
		queue_free()
		Sscore.addPoints(1)
