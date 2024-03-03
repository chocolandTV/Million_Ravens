extends Node

signal highscore_orb_collected(number: int)



func emit_highscore_orb_collected(number:int):
      highscore_orb_collected.emit(number)