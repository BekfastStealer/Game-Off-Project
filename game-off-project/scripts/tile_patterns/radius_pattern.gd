class_name RadiusPattern
extends TilePattern


func _init(board: Board, origin: Board.Tile, min_dist: int, max_dist: int) -> void:
	for x_off: int in range(-max_dist, max_dist + 1):
		var y_dist: int = max_dist - abs(x_off)
		for y_off: int in range(-y_dist, y_dist + 1):
			var tile: Board.Tile = board.coords_to_tile(origin.coords + Vector2i(x_off, y_off))
			if tile == null:
				continue
			if abs(x_off) + abs(y_off) < min_dist:
				continue
			valid_tiles.append(tile)
