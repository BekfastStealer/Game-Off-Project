class_name AgencyComponent
extends Component


@export var move_range: int
var move_ready: bool = true


func move_along_path(path: MovementPlan.Path) -> void:
	var final_tile = path.data[-1]
	entity.board.move_entity(entity, final_tile)
	entity.position = entity.board.tile_position(final_tile)
