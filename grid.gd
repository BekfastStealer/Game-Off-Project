class_name Grid
extends Node2D


@export var dimensions: Vector2i
@export var tile_size: Vector2i
var tile_occupants: Dictionary[Vector2i, Unit]


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


func add_unit(unit: Unit, coords: Vector2i) -> void:
	tile_occupants[coords] = unit
	unit.coords = coords


## Returns true if move was successful
func move_unit(unit: Unit, from: Vector2i, to: Vector2i) -> bool:
	if tile_occupants[from] != unit:
		push_error("From tile doesn't match")
		return false
	if not tile_is_open(to):
		return false
	tile_occupants.erase(from)
	tile_occupants[to] = unit
	unit.coords = to
	return true


func tile_position(coords: Vector2i) -> Vector2:
	return Vector2(tile_size * coords) + Vector2(tile_size) / 2


func tile_is_open(coords: Vector2i) -> bool:
	if not Rect2i(Vector2i.ZERO, dimensions).has_point(coords):
		return false
	if tile_occupants.has(coords):
		return false
	return true
