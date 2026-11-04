class_name TileHighlighter
extends Node2D


@export var _board: Board
var _displayed_pattern: TilePattern = null
#var _displayed_path: MovementPlan.Path = null


func _draw() -> void:
	if _displayed_pattern != null:
		var valid_tiles: Array[Board.Tile] = _displayed_pattern.valid_tiles
		for tile: Board.Tile in valid_tiles:
			draw_rect(_board.tile_rect(tile), Color(Color.CYAN, 0.5))
	
	#if _displayed_path != null:
	#	for tile: Board.Tile in _displayed_path.data:
	#		draw_rect(_board.tile_rect(tile), Color.CYAN)


func display_pattern_tiles(pattern: TilePattern) -> void:
	_displayed_pattern = pattern
	queue_redraw()


#func display_path(path: MovementPlan.Path) -> void:
#	_displayed_path = path
#	queue_redraw()
