extends Control

func _ready() -> void:
	if has_node("/root/Levels"):
		get_node("/root/Levels/CanvasLayer").visible = false  # Hide all UI elements inside
	if has_node("/root/Sscore"):
		get_node("/root/Sscore/CanvasLayer").visible = false
	if has_node("/root/Rscore"):
		get_node("/root/Rscore/CanvasLayer").visible = false
