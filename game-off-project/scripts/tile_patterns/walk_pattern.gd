class_name WalkPattern
extends TilePattern


var paths: Dictionary[Board.Tile, Path]

func _init(board: Board, origin: Board.Tile, max_range: int) -> void:
	var dijkstra_tile_queue: Array[Board.Tile] = [origin]
	var dijkstra_path_queue: Array[Path] = [Path.new(null, origin)]
	var dijkstra_i: int = 0
	# It should be guaranteed that dijkstra_tile_queue and dijkstra_path_queue are always the same length
	while dijkstra_i < dijkstra_tile_queue.size():
		var dijkstra_tile: Board.Tile = dijkstra_tile_queue[dijkstra_i]
		var dijkstra_path: Path = dijkstra_path_queue[dijkstra_i]
		dijkstra_i += 1
		if dijkstra_path.data.size() > max_range:
			continue
		for direction: Vector2i in [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]:
			var step_tile: Board.Tile = board.coords_to_tile(dijkstra_tile.coords + direction)
			# Evaluate if this step can be made in the movement path
			if step_tile == null:
				continue
			if board.entity_at(step_tile) != null:
				# TODO: reevaluate if allies should be able to walk through each other
				continue
			if dijkstra_tile_queue.has(step_tile):
				continue
			# Add the step to the queues and results dictionary
			var step_path: Path = Path.new(dijkstra_path, step_tile)
			dijkstra_tile_queue.append(step_tile)
			dijkstra_path_queue.append(step_path)
			valid_tiles.append(step_tile)
			paths[step_tile] = step_path


func get_path(end_tile: Board.Tile) -> Path:
	return paths[end_tile]
