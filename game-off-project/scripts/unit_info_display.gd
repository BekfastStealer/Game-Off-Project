class_name EntityInfoDisplay
extends Node


@export var player: PlayerController
@export var name_label: Label
var action_buttons: Array[Button]


func _ready() -> void:
	display_entity_info(null)


func display_entity_info(entity: Entity) -> void:
	for action_button: Button in action_buttons:
		action_button.queue_free()
	action_buttons.clear()
	
	if entity == null:
		name_label.hide()
	else:
		name_label.show()
		name_label.text = entity.name
		for component: Component in entity.components.values():
			if component is AgencyComponent:
				for action: Action in component.actions:
					var action_button: Button = Button.new()
					action_button.text = action.get_script().get_global_name()
					action_button.pressed.connect(player.select_action.bind(action))
					$VBoxContainer.add_child(action_button)
					action_buttons.append(action_button)
