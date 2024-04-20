extends Node
class_name  HighscoreManager

var current_highscore : int= 0
var current_feathers : int= 0
var current_coins : int= 0
var current_ravenkills : int =0
@onready var settings : Global_Variables = get_node("/root/GlobalVariables")
# signal highscore_died()
# update ravenkills
signal UI_ravenkilled(raven_killed_amount : int)

#animate score update when gets 1000+
signal UI_bigScore_collected()

func _ready():
      # get event for feather collecting
      GameEvents.highscore_feather_collected.connect(on_highscore_feather_collected)
      #get event for coins collecting
      GameEvents.highscore_coin_collected.connect(on_highscore_coin_collected)
      # get event for orb collecting
      GameEvents.highscore_orb_collected.connect(on_highscore_orb_collected)
      # GameEvents.highscore_player_get_damage.connect(on_highscore_player_get_damage)
      #get event for raven died
      GameEvents.raven_died.connect(on_raven_died)
      on_highscore_reset()

func increment_highscore(number: int):
      if number >=1000:
            UI_bigScore_collected.emit()
      current_highscore += number

func increment_feathers():
      current_feathers += 1
      print("Feather collected, current:",current_feathers)
      GameEvents.emit_UI_update_collectable(0, current_feathers)

func increment_coins():
      current_coins +=1
      print("Coins collected, current:",current_coins)
      GameEvents.emit_UI_update_collectable(1, current_coins)
      

func increment_raven():
      current_ravenkills += 1
      UI_ravenkilled.emit(current_ravenkills)

func on_highscore_orb_collected(number : int):
      increment_highscore(number* settings.gv_score_multiplier)

func on_highscore_coin_collected():
      increment_coins()

func on_highscore_feather_collected():
      increment_feathers()

func on_raven_died():
      increment_raven()

func on_highscore_reset():
      current_highscore = 0
      current_feathers = 0
      current_coins = 0
      current_ravenkills=0

