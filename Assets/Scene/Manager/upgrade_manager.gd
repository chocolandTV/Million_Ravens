extends Node

class_name UpgradeManager

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
var current_upgrades = {}


func _ready():
	experience_manager.level_up.connect(on_level_up)
	GameEvents.ability_upgrade_Button.connect(on_button_clicked)
func on_level_up(current_level : int):
	GameEvents.level_up_show_upgrademenu.emit()

# SIGNAL ON BUTTON ENTERED HERE

func on_button_clicked(value : int):
	#if atk dmg do ATK_UP
	#if atk_sppd do ATK_CD
	#if movment do  SPEED
	#if healthup do +Life
	var chosen_upgrade = upgrade_pool[value]
	apply_upgrade(chosen_upgrade)

func apply_upgrade(upgrade:AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] +=1
	print(upgrade.name,current_upgrades[upgrade.id]["quantity"])
	GameEvents.ability_upgrade_added.emit(upgrade, current_upgrades)