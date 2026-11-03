## Class used to display options for a movement/action waiting to be told what tile to target
@abstract
class_name Plan
extends RefCounted


@abstract func get_valid_tiles() -> Array[Board.Tile]
@abstract func perform(target_tile: Board.Tile) -> void


func tile_is_valid(tile: Board.Tile) -> bool:
	return get_valid_tiles().has(tile)
