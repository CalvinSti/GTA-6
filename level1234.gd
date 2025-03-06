extends Node

var level: int = 1
var score: int = 0  # Persistent score across levels

func add_points(points: int) -> void:
	score += points  # Increase the stored score

func reset_score() -> void:
	score = 0  # Call this if you want to reset the score at some point
