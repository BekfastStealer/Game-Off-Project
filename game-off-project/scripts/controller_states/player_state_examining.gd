class_name PlayerStateExamining
extends PlayerState


var _entity: Entity


func _init(player: PlayerController, entity: Entity) -> void:
	super(player)
	_entity = entity


func _enter() -> void:
	_player.entity_info_display.display_entity_info(_entity)


func _exit() -> void:
	_player.entity_info_display.display_entity_info(null)


func _on_tile_hover(_tile: Board.Tile) -> void:
	pass


func _on_tile_click(tile: Board.Tile) -> void:
	var entity: Entity = _board.entity_at(tile)
	if entity == null:
		_player.set_state(PlayerStateIdle.new(_player))
	elif entity != _entity:
		_player.set_state(PlayerStateExamining.new(_player, entity))


func _on_action_select(_action: Action) -> void:
	var agency: AgencyComponent = _entity.get_component(AgencyComponent)
	_player.set_state(PlayerStatePlanning.new(_player, agency, _action))


func _on_back_press() -> void:
	_player.set_state(PlayerStateIdle.new(_player))
