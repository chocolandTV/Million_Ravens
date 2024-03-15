extends Node
#Orb was collected
signal highscore_orb_collected(number: int)
#Feather was collected
signal highscore_feather_collected()
# Coins was collected
signal highscore_coin_collected()
# Player taken damage
signal highscore_player_get_damage(number:int)

signal winGame_boss_down()

signal increase_raven_spawn()
#abilityCooldownSignals#
signal ability_status_changed(index:int, status:bool)
#ability has been upgraded
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrade:Dictionary)

#signal to get raven count
signal raven_died()

#Signal das Highscore startet
signal highscore_button_pressed()
#Signal Menu Switch on Main Menu
signal menu_switch()
##########################################################
func emit_raven_died():
	raven_died.emit()

func emit_menu_switch():
	menu_switch.emit()
func emit_ability_status_changed(index: int, status: bool):
	ability_status_changed.emit(index,status)
	
func emit_highscore_feather_collected():
	highscore_feather_collected.emit()

func emit_highscore_coin_collected():
	highscore_coin_collected.emit()

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

func emit_highscore_button_pressed():
	highscore_button_pressed.emit()