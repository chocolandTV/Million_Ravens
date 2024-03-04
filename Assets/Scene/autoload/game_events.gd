extends Node
#Orb was collected
signal highscore_orb_collected(number: int)
# Player taken damage
signal highscore_player_get_damage(number:int)

signal winGame_boss_down()

signal increase_raven_spawn()


#ability has been upgraded
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrade:Dictionary)


func emit_highscore_orb_collected(number:int):
	highscore_orb_collected.emit(number)

func emit_highscore_player_get_damage(number:int):
	highscore_player_get_damage.emit(number)

func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)

func emit_winGame_boss_down_event():
	winGame_boss_down.emit()

func emit_increase_raven_spawn_event():
	increase_raven_spawn.emit()