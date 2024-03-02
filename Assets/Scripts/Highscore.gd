
class_name  Highscore

var rank : String ="0"
var playerID : String = ""
var score : int = 0

func getString():
      return ("" +rank + "-" + playerID + "-" + str(score))

func _init(_rank, _playerID, _score):
      rank = _rank
      playerID = _playerID
      score = _score