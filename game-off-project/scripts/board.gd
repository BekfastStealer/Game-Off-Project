class_name Board
extends Node2D


class Tile:
	var coords: Vector2i
	func _init(_coords: Vector2i) -> void:
		coords = _coords

@export var dimensions: Vector2i
@export var tile_size: Vector2
var tiles: Array[Tile]
var tile_entities: Dictionary[Tile, Entity]
var entity_tiles: Dictionary[Entity, Tile]


func _ready() -> void:
	tiles.resize(dimensions.x * dimensions.y)
	for tile_x: int in dimensions.x:
		for tile_y: int in dimensions.y:
			tiles[tile_y * dimensions.x + tile_x] = Tile.new(Vector2i(tile_x, tile_y))


# TODO: temp?
func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(dimensions) * tile_size), Color.WHITE)
	for row_i in dimensions.y + 1:
		draw_line(Vector2(0, tile_size.y * row_i), Vector2(tile_size.x * dimensions.x, tile_size.y * row_i), Color.BLACK)
	for col_i in dimensions.x + 1:
		draw_line(Vector2(tile_size.x * col_i, 0), Vector2(tile_size.x * col_i, tile_size.y * dimensions.y), Color.BLACK)


func is_position_in_bounds(pos: Vector2) -> bool:
	return Rect2(position, Vector2(dimensions) * tile_size).has_point(pos)


func coords_to_tile(coords: Vector2i) -> Tile:
	if Rect2i(Vector2i.ZERO, dimensions).has_point(coords):
		return tiles[coords.y * dimensions.x + coords.x]
	else:
		return null


func position_to_tile(pos: Vector2) -> Tile:
	return coords_to_tile(Vector2i((to_local(pos) / tile_size).floor()))


func tile_position(tile: Tile) -> Vector2:
	assert(tile != null)
	return Vector2(tile.coords) * tile_size + tile_size / 2


func tile_rect(tile: Tile) -> Rect2:
	assert(tile != null)
	return Rect2(Vector2(tile.coords) * tile_size, tile_size)


func entity_at(tile: Tile) -> Entity:
	return tile_entities.get(tile, null)


func add_entity(entity: Entity, tile: Tile) -> void:
	assert(tile != null)
	assert(not tile_entities.has(tile))
	tile_entities[tile] = entity
	entity_tiles[entity] = tile


func move_entity(entity: Entity, tile: Tile) -> void:
	assert(entity_tiles.has(entity))
	assert(tile != null)
	assert(not tile_entities.has(tile))
	var old_tile: Tile = entity_tiles[entity]
	tile_entities.erase(old_tile)
	entity_tiles[entity] = tile
	tile_entities[tile] = entity


func delete_entity(entity: Entity) -> void:
	assert(entity_tiles.has(entity))
	var old_tile: Tile = entity_tiles[entity]
	tile_entities.erase(old_tile)
	entity_tiles.erase(entity)
