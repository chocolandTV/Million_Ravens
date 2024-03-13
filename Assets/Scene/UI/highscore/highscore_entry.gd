extends Panel

@onready var rank_label : Label = $%Rank_value
@onready var playername_label : Label =$%Playername_value
@onready var score_label : Label =$%Score_value
@onready var time_label : Label = $%Time_value
@onready var feather_label : Label = $%Feather_value
@onready var coin_label :Label = $%Coins_value

func _ready():
      pass

func on_initialize_text(rank:String, playername:String, score:String, time:String, feather:String, coin:String):
      rank_label.text = rank
      playername_label.text = playername
      score_label.text = score
      time_label.text = time
      feather_label.text = feather
      coin_label.text = coin
      