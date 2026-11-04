@abstract
class_name TilePattern
extends RefCounted


class Path:
	var data: Array[Board.Tile]
	func _init(prev_path: Path = null, next_step: Board.Tile = null) -> void:
		if prev_path == null:
			data = []
		else:
			data = prev_path.data.duplicate()
		if next_step != null:
			data.append(next_step)

var valid_tiles: Array[Board.Tile]


func get_path(_end_tile: Board.Tile) -> Path:
	return null
