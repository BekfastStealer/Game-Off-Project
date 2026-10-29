class_name Grid
extends Node2D


@export var dimensions: Vector2i
@export var tile_size: Vector2i


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, dimensions * tile_size), Color.WHITE)
	for row_i in dimensions.y + 1:
		draw_line(
				Vector2(0, row_i * tile_size.y),
				Vector2(dimensions.x * tile_size.x, row_i * tile_size.y),
				Color.BLACK)
	for col_i in dimensions.x + 1:
		draw_line(
				Vector2(col_i * tile_size.x, 0),
				Vector2(col_i * tile_size.x, dimensions.y * tile_size.y),
				Color.BLACK)


func tile_position(coords: Vector2i) -> Vector2:
	return Vector2(tile_size * coords) + Vector2(tile_size) / 2
