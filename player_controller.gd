class_name PlayerController
extends Node


@export var character: Unit
@export var camera: Camera2D
## Range 0-1. Lower values follow more closely.
@export var cam_ease_factor: float


func _process(delta: float) -> void:
	# Handle camera easing
	var cam_target: Vector2 = character.global_position - camera.global_position
	var lerp_factor: float = 1 - pow(cam_ease_factor, delta)
	camera.position += cam_target * lerp_factor


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		character.step(Directions.Direction.UP)
	elif event.is_action_pressed("down"):
		character.step(Directions.Direction.DOWN)
	elif event.is_action_pressed("left"):
		character.step(Directions.Direction.LEFT)
	elif event.is_action_pressed("right"):
		character.step(Directions.Direction.RIGHT)
	elif event.is_action_pressed("punch"):
		character.do_action(Unit.Action.PUNCH)
	elif event.is_action_pressed("hop"):
		character.do_action(Unit.Action.HOP)
