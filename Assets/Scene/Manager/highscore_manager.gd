extends Node
class_name  HighscoreManager

var current_highscore = 100
var current_feathers = 0
var current_coins = 0

signal highscore_died

func _ready():
      # get event for feather collecting
      GameEvents.highscore_feather_collected.connect(on_highscore_feather_collected)
      #get event for coins collecting
      GameEvents.highscore_coin_collected.connect(on_highscore_coin_collected)
      # get event for orb collecting
      GameEvents.highscore_orb_collected.connect(on_highscore_orb_collected)
      GameEvents.highscore_player_get_damage.connect(on_highscore_player_get_damage)

func increment_highscore(number: int):
      current_highscore += number

func increment_feathers():
      current_feathers += 1

func increment_coins():
      current_coins +=1

func player_damage_to_highscore(number:int):
      current_highscore-= number
      print("get Highscore_Damage: %d damage" % number)
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