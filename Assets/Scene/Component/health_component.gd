extends Node
class_name HealthComponent

signal died

@export var max_health : float = 1
var current_health

func _ready():
	#Set Current Health to Max Health
	current_health = max_health

func damage(damage_amount : float):
	#Get Damage
	current_health = max(current_health- damage_amount,0)
	#Callable to avoid Godot Error while checking multiply time if entity is dead...
	Callable(check_death).call_deferred()

func check_death():
	
	if current_health == 0:
		died.emit()
		owner.queue_free()
