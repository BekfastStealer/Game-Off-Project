@abstract
class_name PlayerState
extends RefCounted


var _player: PlayerController
var _board: Board


func _init(player: PlayerController) -> void:
	_player = player
	_board = _player.board

@abstract func _enter() -> void
@abstract func _exit() -> void
@abstract func _on_tile_hover(tile: Board.Tile) -> void
@abstract func _on_tile_click(tile: Board.Tile) -> void
