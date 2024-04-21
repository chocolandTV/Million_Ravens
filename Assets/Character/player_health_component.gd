extends Node

class_name PlayerHealthComponent

@export var player_animations : AnimationPlayer
@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")
signal died
var current_player_health : int  = 1000
const BASEHEALTH : int  =1000
func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func damage(damage_amount : int):
	if current_player_health- damage_amount < 0:
		# GAME OVER
		current_player_health -= damage_amount
		GameEvents.emit_PlayerLife_UI_update(current_player_health)
		SoundManager.Emit_Sound(SoundManager.soundType.s_player_dying_sounds,Vector2.ZERO)
		GameEvents.emit_player_died()
	current_player_health -= damage_amount
	if damage_amount > 500:
		# start invisible timer & effect
		GameEvents.emit_player_damaged()
		GameEvents.emit_PlayerLife_UI_update(current_player_health)
		player_animations.play("receive_damage")
		SoundManager.Emit_Sound(SoundManager.soundType.s_player_getDamage_sounds,Vector2.ZERO)
	else:
		print (current_player_health)

func on_damage_invisibility_on():
	
	#hitbox off
	#Timer start
	pass
func onHealthChanged(value : int):
	current_player_health += value
	updateUI()

func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "extraHealth":
		current_player_health = BASEHEALTH + (current_upgrades[upgrade.id]["quantity"])
		globalVars.gv_Settings["player_health_level"]  = current_player_health
		updateUI()

func updateUI():
	GameEvents.emit_ability_upgrade_newLife()
