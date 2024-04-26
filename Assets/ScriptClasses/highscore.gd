
class_name  HighScore

var rank : String ="0"
var playername : String = ""
var score : String = "0"
var time : String = "0"
var feather :String = "0"
var coins :String = "0"

func getString():
      return ("" +rank + "-" + playername + "-" + str(score))

func _init(_rank, _playername, _score, _time, _feather, _coins):
      rank = _rank
      playername = _playername
      score = _score
      time = _time
      feather = _feather
      coins = _coins