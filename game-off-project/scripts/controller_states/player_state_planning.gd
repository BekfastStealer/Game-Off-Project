class_name PlayerStatePlanning
extends PlayerState


var _entity: Entity
var _plan: Plan
var _highlighter: TileHighlighter


func _init(player: PlayerController, entity: Entity, plan: Plan) -> void:
	super(player)
	_entity = entity
	_plan = plan
	_highlighter = _player.highlighter


func _enter() -> void:
	_highlighter.display_plan_tiles(_plan)


func _exit() -> void:
	_highlighter.display_plan_tiles(null)
	_highlighter.display_path(null)


func _on_tile_hover(tile: Board.Tile) -> void:
	if _plan is MovementPlan:
		var m_plan: MovementPlan = _plan
		_highlighter.display_path(m_plan.get_path(tile))


func _on_tile_click(tile: Board.Tile) -> void:
	if _plan.tile_is_valid(tile):
		_plan.perform(tile)
		_player.set_state(PlayerStateExamining.new(_player, _entity))
