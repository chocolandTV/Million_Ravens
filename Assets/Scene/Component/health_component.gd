extends Node
class_name HealthComponent

signal died
signal health_changed
@export var isGameObject : bool = false
@export var max_health : float = 1
var current_health

func _ready():
	#Set Current Health to Max Health
	current_health = max_health

func damage(damage_amount : float):
	#Get Damage
	print("damage")
	current_health = max(current_health - damage_amount,0)
	health_changed.emit()
	#Callable to avoid Godot Error while checking multiply time if entity is dead...
	Callable(check_death).call_deferred()

func get_health_percent():
	if max_health<=0:
		return 0
	return min(current_health / max_health,1)

func check_death():
	
	if current_health == 0:
		died.emit()
		if !isGameObject:
			GameEvents.emit_raven_died()
			owner.queue_free()
