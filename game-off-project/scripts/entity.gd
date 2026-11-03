class_name Entity
extends Node2D


@export var start_coords: Vector2i
var board: Board
var components: Dictionary[GDScript, Component]


func _ready() -> void:
	board = get_parent() as Board
	await board.ready
	var tile: Board.Tile = board.coords_to_tile(start_coords)
	board.add_entity(self, tile)
	position = board.tile_position(tile)


func get_tile() -> Board.Tile:
	return board.entity_tiles[self]


func get_component(type: GDScript) -> Component:
	return components.get(type, null)


func destroy() -> void:
	board.delete_entity(self)
	self.queue_free()
