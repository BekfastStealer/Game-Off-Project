class_name MovementPlan
extends Plan


class Path:
	var data: Array[Board.Tile]
	func _init(prev_path: Path = null, next_step: Board.Tile = null) -> void:
		if prev_path == null:
			data = []
		else:
			data = prev_path.data.duplicate()
		if next_step != null:
			data.append(next_step)

var _agency: AgencyComponent
var path_options: Dictionary[Board.Tile, Path]


func _init(agency: AgencyComponent) -> void:
	_agency = agency
	var entity: Entity = agency.entity
	var start_tile: Board.Tile = entity.get_tile()
	var board: Board = entity.board
	var move_range: int = agency.move_range
	# Dijkstra's algorithm to determine what tiles are reachable
	path_options = {}
	var dijkstra_tile_queue: Array[Board.Tile] = [start_tile]
	var dijkstra_path_queue: Array[Path] = [Path.new(null, start_tile)]
	var dijkstra_i: int = 0
	# It should be guaranteed that dijkstra_tile_queue and dijkstra_path_queue are always the same length
	while dijkstra_i < dijkstra_tile_queue.size():
		var dijkstra_tile: Board.Tile = dijkstra_tile_queue[dijkstra_i]
		var dijkstra_path: Path = dijkstra_path_queue[dijkstra_i]
		dijkstra_i += 1
		if dijkstra_path.data.size() > move_range:
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
			path_options[step_tile] = step_path


func perform(target_tile: Board.Tile) -> void:
	_agency.move_along_path(get_path(target_tile))


func get_valid_tiles() -> Array[Board.Tile]:
	return path_options.keys()


func get_path(tile: Board.Tile) -> Path:
	return path_options.get(tile, null)
