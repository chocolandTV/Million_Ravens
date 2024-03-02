extends Node

var current_highscore = 0

func increment_highscore(number: int):
      current_highscore += number
      print(current_highscore)