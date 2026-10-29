class_name Unit
extends Sprite2D


enum Action {
	PUNCH,
	HOP
}

@export var grid: Grid
@export var start_coords: Vector2i
@export var animations: AnimationPlayer

# TODO: these are temporary for placeholder animations
@export var jump_height: float
@export var jump_amt: float
@export var punch_angle: float
@export var punch_amt: float

var coords: Vector2i


func _ready() -> void:
	grid.add_unit(self, start_coords)
	position = grid.tile_position(coords)
	# TODO: other starting positions?


# TODO: this whole thing is temporary
func _process(_delta: float) -> void:
	position = grid.tile_position(coords) + Vector2.UP * jump_height * jump_amt
	rotation_degrees = punch_angle * punch_amt


## Returns true if the move was valid, false otherwise
func snap_to_tile(new_coords: Vector2i) -> bool:
	var success: bool = _move_internal(new_coords)
	if not success:
		return false
	position = grid.tile_position(coords)
	return true


func step(direction: Directions.Direction) -> bool:
	var success: bool = snap_to_tile(coords + Directions.to_vector(direction))
	if not success: #TODO: this is temporary
		print("Can't step there")
	return success


func do_action(action: Action) -> void:
	match action:
		Action.PUNCH:
			animations.stop()
			animations.play("Punch")
		Action.HOP:
			animations.stop()
			animations.play("Hop")
		_:
			push_error("Unimplemented Action")


func _move_internal(new_coords: Vector2i) -> bool:
	return grid.move_unit(self, coords, new_coords)
