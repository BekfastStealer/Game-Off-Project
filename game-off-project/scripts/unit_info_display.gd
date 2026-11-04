class_name EntityInfoDisplay
extends Node


@export var player: PlayerController
@export var name_label: Label
var temp_ui: Array[Control]


func _ready() -> void:
	display_entity_info(null)


func display_entity_info(entity: Entity) -> void:
	for old_temp_ui: Control in temp_ui:
		old_temp_ui.queue_free()
	temp_ui.clear()
	
	if entity == null:
		name_label.hide()
	else:
		name_label.show()
		name_label.text = entity.name
		for component: Component in entity.components.values():
			if component is HealthComponent:
				var health_label: Label = Label.new()
				health_label.text = "%d / %d HP" % [component.health, component.max_health]
				$VBoxContainer.add_child(health_label)
				temp_ui.append(health_label)
				
			elif component is TeamComponent:
				var team_label: Label = Label.new()
				team_label.text = "Team: %s" % TeamComponent.Team.keys()[component.team]
				$VBoxContainer.add_child(team_label)
				temp_ui.append(team_label)
				
			if component is AgencyComponent:
				for action: Action in component.actions:
					var action_button: Button = Button.new()
					action_button.text = action.get_script().get_global_name()
					action_button.pressed.connect(player.select_action.bind(action))
					$VBoxContainer.add_child(action_button)
					temp_ui.append(action_button)
