extends Node

class_name PlayerHealthComponent

var current_health= 10

signal died

func damage(damage_amount : float):
	#Get Damage
	GameEvents.emit_highscore_player_get_damage(int(damage_amount))
	#Callable to avoid Godot Error while checking multiply time if entity is dead...
	Callable(check_death).call_deferred()

func check_death():
	
	if current_health == 0:
		died.emit()
		owner.queue_free()
