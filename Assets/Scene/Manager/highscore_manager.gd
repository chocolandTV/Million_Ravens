extends Node
class_name  HighscoreManager

var current_highscore : int= 0
var current_RavenLords : int= 0
var current_coins : int= 0
var current_ravenkills : int =0
@onready var settings : Global_Variables = get_node("/root/GlobalVariables")
# signal highscore_died()
# update ravenkills
signal UI_ravenkilled(raven_killed_amount : int)

#animate score update when gets 1000+
signal UI_bigScore_collected()

func _ready():
      GameEvents.highscore_ravenlord_collected.connect(on_highscore_ravenlord_collected)
      #get event for coins collecting
      GameEvents.highscore_coin_collected.connect(on_highscore_coin_collected)
      # get event for orb collecting
      GameEvents.highscore_orb_collected.connect(on_highscore_orb_collected)
      GameEvents.raven_died.connect(on_raven_died)
      on_highscore_reset()

func increment_highscore(number: int):
      if number >=1000:
            UI_bigScore_collected.emit()
      current_highscore += number

func increment_RavenLord():
      current_RavenLords +=1
      print("Ravenlord collected, current:",current_RavenLords)
      GameEvents.ui_update_collectable.emit(1, current_RavenLords)

func increment_coins():
      current_coins +=1
      print("Coins collected, current:",current_coins)
      GameEvents.ui_update_collectable.emit(1, current_coins)
      

func increment_raven():
      current_ravenkills += 1
      UI_ravenkilled.emit(current_ravenkills)

func on_highscore_orb_collected(number : int):
      increment_highscore(number* settings.gv_score_multiplier)

func on_highscore_coin_collected():
      increment_coins()

func on_highscore_ravenlord_collected():
      increment_RavenLord()

func on_raven_died():
      increment_raven()

func on_highscore_reset():
      current_highscore = 0
      current_RavenLords = 0
      current_coins = 0
      current_ravenkills=0

