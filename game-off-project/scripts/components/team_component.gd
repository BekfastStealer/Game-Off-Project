class_name TeamComponent
extends Component


enum Team {
	PLAYERS,
	ENEMIES,
}

@export var team: Team


static func same_team(entity1: Entity, entity2: Entity) -> bool:
	var team1: TeamComponent = entity1.get_component(TeamComponent)
	var team2: TeamComponent = entity2.get_component(TeamComponent)
	if team1 == null or team2 == null:
		return false
	return team1.team == team2.team
