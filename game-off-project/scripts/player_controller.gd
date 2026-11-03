class_name PlayerController
extends Node2D


@export var board: Board
@export var camera: TacticsCamera
@export var highlighter: TileHighlighter
var state: PlayerState


func _ready() -> void:
	camera.clicked_tile.connect(_on_tile_click)
	camera.hovered_tile.connect(_on_tile_hover)
	state = PlayerStateIdle.new(self)
	state._enter()


func _on_tile_click(tile: Board.Tile) -> void:
	state._on_tile_click(tile)


func _on_tile_hover(tile: Board.Tile) -> void:
	state._on_tile_hover(tile)


func set_state(new_state: PlayerState) -> void:
	var old_state: PlayerState = state
	state = new_state
	old_state._exit()
	new_state._enter()
