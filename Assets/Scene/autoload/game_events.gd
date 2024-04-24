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
#signal Player is Hiding
signal playerIsHiding(value : bool)
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
# SIGNAL Sound_UI_Change integer for type 1:Master 2: Music 3: Sound 4: Ambience, float for value 0-1
signal menu_sound_volume_change(type : int, newVolume : float)

signal ui_update_highscore_multiplier(type : int)
### WÜRDE AUCH FUNKTIONEN GAME_EVENTS.raven_died.emit()
signal get_leaderboards_is_finished()
