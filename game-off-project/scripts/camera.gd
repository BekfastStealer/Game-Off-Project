class_name TacticsCamera
extends Camera2D


signal clicked_tile(tile: Board.Tile)
signal hovered_tile(tile: Board.Tile)

@export var cam_speed: Vector2
@export var board: Board
var mouse_tile: Board.Tile


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var pan_input: Vector2 = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down")
	position += pan_input * cam_speed * delta
	
	var new_mouse_tile: Board.Tile = board.position_to_tile(get_global_mouse_position())
	if new_mouse_tile != mouse_tile:
		mouse_tile = new_mouse_tile
		hovered_tile.emit(mouse_tile)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var m_event: = event as InputEventMouseButton
		if m_event.button_index == MOUSE_BUTTON_LEFT and m_event.pressed:
			var m_tile: Board.Tile = board.position_to_tile(get_global_mouse_position())
			clicked_tile.emit(m_tile)
