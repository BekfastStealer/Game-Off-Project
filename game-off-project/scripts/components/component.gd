class_name Component
extends Node2D


var entity: Entity


func _ready() -> void:
	entity = get_parent() as Entity
	entity.components[get_script()] = self
