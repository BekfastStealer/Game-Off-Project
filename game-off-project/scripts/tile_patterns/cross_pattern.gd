class_name CrossPattern
extends TilePattern


var paths: Dictionary[Board.Tile, Path]

func _init(board: Board, origin: Board.Tile, min_dist: int, max_dist: int) -> void:
	for direction: Vector2i in [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]:
		var tile: Board.Tile = origin
		var path: Path = Path.new(null, origin)
		for dist: int in range(1, max_dist + 1):
			tile = board.coords_to_tile(tile.coords + direction)
			if tile == null:
				break
			path = Path.new(path, tile)
			if dist > min_dist or (dist == min_dist and board.entity_at(tile) == null):
				valid_tiles.append(tile)
				paths[tile] = path
			if board.entity_at(tile) != null:
				break


func get_path(end_tile: Board.Tile) -> Path:
	return paths[end_tile]
