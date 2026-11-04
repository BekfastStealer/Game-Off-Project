class_name ShoutAction
extends Action


@export var max_range: int
@export var damage: int
@export var healing: int


func planning_step(data: Data) -> void:
	if data.targets.size() == 0:
		data.patterns.append(RadiusPattern.new(data.board, data.user.get_tile(), 1, max_range))
	else:
		data.is_ready = true


func perform(data: Data) -> void:
	var target_entity: Entity = data.board.entity_at(data.targets[0])
	if target_entity == null:
		return
	var target_health: HealthComponent = target_entity.get_component(HealthComponent)
	if target_health == null:
		return
	if TeamComponent.same_team(data.user, target_entity):
		target_health.heal(healing)
	else:
		target_health.damage(damage)
