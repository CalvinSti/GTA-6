extends Area2D
class_name shiplayer

@onready var game_over_scene = preload("GameOver.tscn")
@onready var muzzle2 = $Muzzle2
var laser_scene = preload("laser.tscn")

var hp = 1

func _process(delta):
	var viewport_rect = get_viewport_rect()  # Get the viewport size
	var mouse_pos = get_global_mouse_position()
	
	# Clamp the position to stay within the window bounds
	global_position.x = clamp(mouse_pos.x, 0, viewport_rect.size.x)
	global_position.y = clamp(mouse_pos.y, 0, viewport_rect.size.y)

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
		var game_over = game_over_scene.instantiate()
		get_tree().current_scene.add_child(game_over)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("dog"):
		area.take_damage(1)
	if area is dog:
		area.take_damage(1)
	if area is dogs:
		area.take_damage(1)
	if area.is_in_group("enemies"):
		area.take_damage(1)
	if area.is_in_group("dogs"):
		area.take_damage(1)
		
		
		
func _ready():
	$Timer.wait_time = 0.35 # Adjust firing rate (0.5 = fires every 0.5s)
	$Timer.start()  # Start the timer
	$Timer.timeout.connect(shoot_laser)  # Call shoot_laser() when timer runs out

func shoot_laser():
	if hp <= 0:
		return
	var muzzle = $Muzzle2  # Get the Marker2D node
	var laser = laser_scene.instantiate()  # Create a laser instance
	laser.global_position = muzzle.global_position  # Spawn at Muzzle2 position
	get_parent().add_child(laser)  # Add laser to the scene
