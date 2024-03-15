extends Node
class_name  HighscoreManager

var current_highscore : int= 100
var current_feathers : int= 0
var current_coins : int= 0
var current_ravenkills : int =0

signal highscore_died()
# update ravenkills
signal UI_ravenkilled(raven_killed_amount : int)
#update feathers
signal UI_feather_collected()
#update coins
signal UI_coin_collected()
#animate score update when gets 1000+
signal UI_bigScore_collected()

func _ready():
      # get event for feather collecting
      GameEvents.highscore_feather_collected.connect(on_highscore_feather_collected)
      #get event for coins collecting
      GameEvents.highscore_coin_collected.connect(on_highscore_coin_collected)
      # get event for orb collecting
      GameEvents.highscore_orb_collected.connect(on_highscore_orb_collected)
      GameEvents.highscore_player_get_damage.connect(on_highscore_player_get_damage)
      #get event for raven died
      GameEvents.raven_died.connect(on_raven_died)

func increment_highscore(number: int):
      if number >=1000:
            UI_bigScore_collected.emit()
      current_highscore += number

func increment_feathers():
      current_feathers += 1
      UI_feather_collected.emit()

func increment_coins():
      current_coins +=1
      UI_coin_collected.emit()

func increment_raven():
      current_ravenkills += 1
      UI_ravenkilled.emit(current_ravenkills)

func player_damage_to_highscore(number:int):
      current_highscore-= number
      #if current_highscore < 0 GAME OVER
      if current_highscore < 0:
            on_highscore_died_event()

func on_highscore_player_get_damage(number: int):
      player_damage_to_highscore(number)

func on_highscore_died_event():
      highscore_died.emit()

func on_highscore_orb_collected(number : int):
      increment_highscore(number)

func on_highscore_coin_collected():
      increment_coins()

func on_highscore_feather_collected():
      increment_feathers()

func on_raven_died():
      increment_raven()

