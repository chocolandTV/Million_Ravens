extends Node

class_name PlayerHealthComponent

@export var player_animations : AnimationPlayer

signal died

func damage(damage_amount : float):
	#Get Damage
	GameEvents.emit_highscore_player_get_damage(int(damage_amount))
	# Animate
	#if !player_animations.is_playing:
	player_animations.play("receive_damage")

