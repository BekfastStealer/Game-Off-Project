class_name PlayerStateExamining
extends PlayerState


var _entity: Entity


func _init(player: PlayerController, entity: Entity) -> void:
	super(player)
	_entity = entity


func _enter() -> void:
	# TODO: don't jump the gun on moving
	var agency: AgencyComponent = _entity.get_component(AgencyComponent)
	if agency == null:
		return
	var move_plan: MovementPlan = MovementPlan.new(agency)
	_player.set_state(PlayerStatePlanning.new(_player, _entity, move_plan))


func _exit() -> void:
	pass


func _on_tile_hover(_tile: Board.Tile) -> void:
	pass


func _on_tile_click(tile: Board.Tile) -> void:
	var entity: Entity = _board.entity_at(tile)
	if entity == null:
		_player.set_state(PlayerStateIdle.new(_player))
	elif entity != _entity:
		_player.set_state(PlayerStateExamining.new(_player, entity))
