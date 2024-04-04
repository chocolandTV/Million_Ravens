extends Node
#Orb was collected
signal highscore_orb_collected(number: int)
#Feather was collected
signal highscore_feather_collected()
# Coins was collected
signal highscore_coin_collected()

signal winGame_boss_down()

signal increase_raven_spawn()
#abilityUpgradeSignal
signal ability_upgrade_Button(index:int)
# signal show abilitys in globalUI
signal level_up_show_upgrademenu()
#ability has been upgraded
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrade:Dictionary)
#signal update Healthup
signal ability_upgrade_newLife()
#signal update LIFE_UI
signal PlayerLife_UI_update(value : int)

#PLAYER DAMAGE
signal player_damaged()
#signal player died
signal player_died()
#signal to get raven count
signal raven_died()
#Signal das Highscore startet
signal highscore_button_pressed()
#signal update UI Collectables
signal ui_update_collectable(switch : int, value : int)
#Signal Menu Switch on Main Menu
signal menu_switch()
##########################################################
func emit_raven_died():
	raven_died.emit()

func emit_player_damaged():
	player_damaged.emit()

func emit_player_died():
	player_died.emit()

func emit_menu_switch():
	menu_switch.emit()
	
func emit_ability_upgrade_Button(index: int):
	# Int 1 ATK, 2 ATKSPEED, 3 MOVSPEED, 4 Life
	ability_upgrade_Button.emit(index)

func emit_level_up_show_upgrademenu():
	level_up_show_upgrademenu.emit()

func emit_highscore_feather_collected():
	highscore_feather_collected.emit()

func emit_highscore_coin_collected():
	highscore_coin_collected.emit()

func emit_highscore_orb_collected(number:int):
	highscore_orb_collected.emit(number)

func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)

func emit_ability_upgrade_newLife():
	ability_upgrade_newLife.emit()

func emit_PlayerLife_UI_update(_value : int):
	PlayerLife_UI_update.emit(_value)

func emit_UI_update_collectable(switch : int, value :int):
	ui_update_collectable.emit(switch,value)

func emit_winGame_boss_down_event():
	winGame_boss_down.emit()

func emit_increase_raven_spawn_event():
	increase_raven_spawn.emit()

func emit_highscore_button_pressed():
	highscore_button_pressed.emit()

