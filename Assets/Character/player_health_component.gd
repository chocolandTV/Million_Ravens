extends Node

class_name PlayerHealthComponent

@export var player_animations : AnimationPlayer
@export var player_hurtbox : PlayerHurtboxComponent

@onready var timer : Timer =$InvincibleTimer
@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")
signal died
var current_player_health : int  = 3000
const BASEHEALTH : int  =3000
func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	timer.timeout.connect(on_invincible_timeout)

func damage(damage_amount : int):
	current_player_health -= damage_amount
	GameEvents.PlayerLife_UI_update.emit(current_player_health)

	if current_player_health- damage_amount < 0:
		# GAME OVER
		current_player_health = 0
		SoundManager.Emit_Sound(SoundManager.soundType.s_player_dying_sounds,Vector2.ZERO)
		GameEvents.player_died.emit()
	if damage_amount > 250:
		# start invisible timer & effect
		Callable(on_damage_invisibility_on).call_deferred()
		GameEvents.player_damaged.emit()
		player_animations.play("receive_damage")
		SoundManager.Emit_Sound(SoundManager.soundType.s_player_getDamage_sounds,Vector2.ZERO)

func on_damage_invisibility_on():
	print("invincible on")
	player_hurtbox.set_deferred("monitoring",false)
	timer.start()

func on_invincible_timeout():
	print("invincible off")
	player_hurtbox.set_deferred("monitoring",true)

func onHealthChanged(value : int):
	current_player_health += value
	updateUI()

func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "extraHealth":
		current_player_health = BASEHEALTH + ((current_upgrades[upgrade.id]["quantity"])*1000)
		globalVars.gv_Settings["player_health_level"]  = current_player_health
		updateUI()

func updateUI():
	GameEvents.ability_upgrade_newLife.emit(current_player_health)
