extends Node
class_name HealthComponent

signal died (_damage_type : int)
signal health_changed
@export var isGameObject : bool = false
@export var max_health : float = 1
var current_health
var _damage_type = 0
func _ready():
	#Set Current Health to Max Health
	current_health = max_health

func apply_health_bonus(health_amount : int):
	max_health += health_amount
	current_health =max_health
	health_changed.emit()

func damage(damage_amount, damage_type : int):
	current_health = max(current_health - damage_amount,0)
	health_changed.emit()
	_damage_type = damage_type
	#Callable to avoid Godot Error while checking multiply time if entity is dead...
	Callable(check_death).call_deferred()

func get_health_percent():
	if max_health<=0:
		return 0
	return min(current_health / max_health,1)

func check_death():
	
	if current_health == 0:
		died.emit(_damage_type)
		if !isGameObject:
			GameEvents.raven_died.emit()
			owner.queue_free()
