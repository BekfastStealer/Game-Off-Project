class_name RamAction
extends Action


@export var min_range: int
@export var max_range: int
@export var damage: int

func planning_step(data: Data) -> void:
	if data.targets.size() == 0:
		data.patterns.append(CrossPattern.new(data.board, data.user.get_tile(), min_range, max_range))
	else:
		data.is_ready = true


func perform(data: Data) -> void:
	var end_tile: Board.Tile
	var slam_target: Entity = data.board.entity_at(data.targets[0])
	if slam_target == null:
		end_tile = data.targets[0]
	else:
		end_tile = data.patterns[0].get_path(data.targets[0]).data[-2]
		var target_health: HealthComponent = slam_target.get_component(HealthComponent)
		if target_health != null:
			target_health.damage(damage)
	
	data.board.move_entity(data.user, end_tile)
	# TODO: smooth movement
	data.user.position = data.board.tile_position(end_tile)
