@abstract
class_name Action
extends Resource


class Data:
	var user: Entity
	var board: Board
	var targets: Array[Board.Tile] = []
	var patterns: Array[TilePattern] = []
	var is_ready: bool = false
	func _init(_user_agency: AgencyComponent) -> void:
		user = _user_agency.entity
		board = user.board
	func add_target(target: Board.Tile) -> void:
		targets.append(target)
	func pop_target() -> void:
		targets.pop_back()
		patterns.pop_back()


## Modifies the Data object that was passed in
@abstract func planning_step(data: Data) -> void
@abstract func perform(data: Data) -> void
