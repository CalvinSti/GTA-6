extends Node2D

@onready var brickObject = preload("breek.tscn")

var columns = 9
var rows = 11
var margin = 15

func _ready() -> void:
	setupLevel()
	if has_node("/root/Levels"):
		get_node("/root/Levels/CanvasLayer").visible = true
	if has_node("/root/Sscore"):
		get_node("/root/Sscore/CanvasLayer").visible = false
	if has_node("/root/Rscore"):
		get_node("/root/Rscore/CanvasLayer").visible = false

func setupLevel():
	for r in rows:
		for c in columns:
			var randomNumber = randi_range(0, 1.5)
			if randomNumber > 0:
				var newBrick = brickObject.instantiate()
				add_child(newBrick)
				newBrick.position = Vector2(margin + (11 * c), margin + (11 * r))
			
			
