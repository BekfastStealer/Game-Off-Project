class_name WalkAction
extends Action


@export var max_range: int

func planning_step(data: Data) -> void:
	if data.targets.size() == 0:
		data.patterns.append(WalkPattern.new(data.board, data.user.get_tile(), max_range))
	else:
		data.is_ready = true


func perform(data: Data) -> void:
	data.board.move_entity(data.user, data.targets[0])
	# TODO: smooth movement
	data.user.position = data.board.tile_position(data.targets[0])
