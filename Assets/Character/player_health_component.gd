extends Node

class_name PlayerHealthComponent

@export var player_animations : AnimationPlayer
@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")
signal died
var player_health : int  = 1
const BASEHEALTH : int  =1 
func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func damage(damage_amount : int):
	#Get Damage
	print ("get damage :", damage_amount)
	if player_health- damage_amount < 0:
		# GAME OVER
		player_health -= damage_amount
		GameEvents.emit_PlayerLife_UI_update(player_health)
		GameEvents.emit_player_died()
	# GameEvents.emit_highscore_player_get_damage(int(damage_amount))
	player_health -= damage_amount
	GameEvents.emit_PlayerLife_UI_update(player_health)
	# Animate
	#if !player_animations.is_playing:
	player_animations.play("receive_damage")

func on_damage_invisibility_on():
	
	#hitbox off
	#Timer start
	pass
func onHealthChanged(value : int):
	player_health += value
	updateUI()

func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "extraHealth":
		player_health = BASEHEALTH + (current_upgrades[upgrade.id]["quantity"])
		globalVars.gv_Settings["player_health_level"]  = player_health
		updateUI()

func updateUI():
	GameEvents.emit_ability_upgrade_newLife()

func on_timer_timeout():
	#hitbox on
	pass