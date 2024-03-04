extends Node

var current_highscore = 1
signal highscore_died

func _ready():
      GameEvents.highscore_orb_collected.connect(on_highscore_orb_collected)
      GameEvents.highscore_player_get_damage.connect(on_highscore_player_get_damage)

func increment_highscore(number: int):
      current_highscore += number
      #print(current_highscore)

func on_highscore_orb_collected(number : int):
      increment_highscore(number)

func player_damage_to_highscore(number:int):
      current_highscore-= number
      #if current_highscore < 0 GAME OVER
      if current_highscore < 0:
            on_highscore_died_event()

func on_highscore_player_get_damage(number: int):
      player_damage_to_highscore(number)

func on_highscore_died_event():
      highscore_died.emit()