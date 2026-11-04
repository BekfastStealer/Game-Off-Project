class_name PlayerController
extends Node2D


@export var board: Board
@export var camera: TacticsCamera
@export var highlighter: TileHighlighter
@export var entity_info_display: EntityInfoDisplay
var state: PlayerState


func _ready() -> void:
	camera.clicked_tile.connect(_on_tile_click)
	camera.hovered_tile.connect(_on_tile_hover)
	state = PlayerStateIdle.new(self)
	state._enter()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		state._on_back_press()


func _on_tile_click(tile: Board.Tile) -> void:
	state._on_tile_click(tile)


func _on_tile_hover(tile: Board.Tile) -> void:
	state._on_tile_hover(tile)


func select_action(action: Action) -> void:
	state._on_action_select(action)


func set_state(new_state: PlayerState) -> void:
	var old_state: PlayerState = state
	state = new_state
	old_state._exit()
	new_state._enter()
