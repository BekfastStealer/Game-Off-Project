class_name PunchAction
extends Action


@export var damage: int


func planning_step(data: Data) -> void:
	if data.targets.size() == 0:
		data.patterns.append(RadiusPattern.new(data.board, data.user.get_tile(), 1, 1))
	else:
		data.is_ready = true


func perform(data: Data) -> void:
	var target_entity: Entity = data.board.entity_at(data.targets[0])
	if target_entity == null:
		return
	var target_health: HealthComponent = target_entity.get_component(HealthComponent)
	if target_health == null:
		return
	target_health.damage(damage)
