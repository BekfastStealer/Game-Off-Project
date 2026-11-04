class_name HealthComponent
extends Component


signal health_changed(new_value: int)
signal died()

@export var max_health: int
var health: int


func _ready() -> void:
	super()
	health = max_health


func damage(amount: int) -> void:
	if amount <= 0:
		return
	health -= amount
	health_changed.emit(health)
	if health <= 0:
		die()


func heal(amount: int) -> void:
	if amount <= 0:
		return
	health += amount
	if health > max_health:
		health = max_health
	health_changed.emit(health)


func die() -> void:
	died.emit()
	entity.destroy()
