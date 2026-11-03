class_name PlayerStateIdle
extends PlayerState


func _init(player: PlayerController) -> void:
	super(player)


func _enter() -> void:
	pass


func _exit() -> void:
	pass


func _on_tile_hover(_tile: Board.Tile) -> void:
	pass


func _on_tile_click(tile: Board.Tile) -> void:
	var entity: Entity = _board.entity_at(tile)
	if entity != null:
		_player.set_state(PlayerStateExamining.new(_player, entity))
