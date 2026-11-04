class_name PlayerStatePlanning
extends PlayerState


var _agency: AgencyComponent
var _action: Action
var _action_data: Action.Data
var _highlighter: TileHighlighter


func _init(player: PlayerController, agency: AgencyComponent, action: Action) -> void:
	super(player)
	_agency = agency
	_action = action
	_highlighter = _player.highlighter


func _enter() -> void:
	_action_data = Action.Data.new(_agency)
	update_action()


func _exit() -> void:
	_highlighter.display_pattern_tiles(null)


func _on_tile_hover(_tile: Board.Tile) -> void:
	pass


func _on_tile_click(tile: Board.Tile) -> void:
	if _action_data.patterns[-1].valid_tiles.has(tile):
		_action_data.add_target(tile)
		update_action()


func _on_back_press() -> void:
	_player.set_state(PlayerStateExamining.new(_player, _agency.entity))


func update_action() -> void:
	_action.planning_step(_action_data)
	if _action_data.is_ready:
		_action.perform(_action_data)
		_player.set_state(PlayerStateExamining.new(_player, _agency.entity))
	else:
		_highlighter.display_pattern_tiles(_action_data.patterns[-1])
