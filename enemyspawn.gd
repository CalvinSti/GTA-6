extends Node2D

var spawnpositions = null

var enemy = preload("ohthemisery.tscn")

func _ready():
	randomize()
	spawnpositions = $position.get_children()

func spawn_enemy():
	var index = randi() % spawnpositions.size()
	var enemy = enemy.instantiate()
	enemy.global_position = spawnpositions[index].global_position
	add_child(enemy)

func _on_timer_timeout() -> void:
	spawn_enemy()
