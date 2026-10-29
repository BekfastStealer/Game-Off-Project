class_name Unit
extends Sprite2D


enum Action {
	PUNCH,
	HOP
}

@export var grid: Grid
@export var animations: AnimationPlayer

# TODO: these are temporary for placeholder animations
@export var jump_height: float
@export var jump_amt: float
@export var punch_angle: float
@export var punch_amt: float

var coords: Vector2i


func _ready() -> void:
	# TODO: other starting positions?
	snap_to_tile(Vector2i.ZERO)


# TODO: this whole thing is temporary
func _process(_delta: float) -> void:
	position = grid.tile_position(coords) + Vector2.UP * jump_height * jump_amt
	rotation_degrees = punch_angle * punch_amt


## Returns true if the move was valid, false otherwise
func snap_to_tile(new_coords: Vector2i) -> bool:
	if not Rect2i(Vector2i.ZERO, grid.dimensions).has_point(new_coords):
		return false
	coords = new_coords
	position = grid.tile_position(coords)
	return true


func step(direction: Directions.Direction) -> bool:
	var could_step: bool = snap_to_tile(coords + Directions.to_vector(direction))
	if not could_step: #TODO: this is temporary
		print("Can't step there")
	return could_step


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
