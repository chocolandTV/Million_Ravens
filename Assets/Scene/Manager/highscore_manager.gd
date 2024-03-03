extends Node


var current_highscore = 0


func _ready():
      GameEvents.highscore_orb_collected.connect(on_highscore_orb_collected)

func increment_highscore(number: int):
      current_highscore += number
      #print(current_highscore)

func on_highscore_orb_collected(number : int):
      increment_highscore(number)