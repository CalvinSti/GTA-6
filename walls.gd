extends Node2D

onready var right_wall = $RightWall

func _ready():
	var screen_size = get_viewport_rect().size

	# Set wall sizes
	set_wall_size(top_wall, Vector2(screen_size.x, 10), Vector2(screen_size.x / 2, 5))
	set_wall_size(left_wall, Vector2(10, screen_size.y), Vector2(5, screen_size.y / 2))
	set_wall_size(right_wall, Vector2(10, screen_size.y), Vector2(screen_size.x - 5, screen_size.y / 2))

func set_wall_size(wall: StaticBody2D, size: Vector2, pos: Vector2):
	var shape = wall.get_node("CollisionShape2D")
	shape.shape = RectangleShape2D.new()
	shape.shape.extents = size / 2  # Half-size because extents are used
	wall.position = pos
