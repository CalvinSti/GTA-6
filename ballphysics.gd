extends CharacterBody2D

var speed = 2
var dir = Vector2.DOWN
var is_active = true
@onready var game_over_scene = preload("GameOver.tscn")

func _ready() -> void: 
	velocity = Vector2(speed * -1, speed)
	

func _physics_process(delta: float) -> void:
	if is_active:
		
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()
			
		if(velocity.y > 0 and velocity.y < 10):
			velocity.y = - 100
		
		if velocity.x == 0:
			velocity.x - 200
			
		
func gameOver():
	queue_free()  # Remove player
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	gameOver()
	var game_over = game_over_scene.instantiate()
	get_tree().current_scene.add_child(game_over)  # Add Game Over UI
	
