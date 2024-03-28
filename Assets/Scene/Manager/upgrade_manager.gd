extends Node

class_name UpgradeManager

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene:PackedScene

var current_upgrades = {}


func _ready():
	experience_manager.level_up.connect(on_level_up)

func on_level_up(current_level : int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	apply_upgrade(chosen_upgrade)


func apply_upgrade(upgrade:AbilityUpgrade):

	# print(upgrade.name,current_upgrades[upgrade.id]["quantity"])

	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] +=1
	print(upgrade.name,current_upgrades[upgrade.id]["quantity"])
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
		
func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)