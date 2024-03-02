extends Panel

@onready var filemanager : Filemanager = get_node("/root/GlobalFileManager")
@onready var settings : Global_Settings = get_node("/root/GlobalSetting")
@onready var highscoreManager : HighscoreSystem = get_node("/root/HighscoreManager")

@export var rankList :Array[Label]
@export var playernameList : Array[Label]
@export var playerScoreList : Array[Label]
@export var scoreUI : LineEdit

#Buttons
@export var button01 :Button
@export var button02 :Button
@export var button03 :Button
@export var button04 :Button

@export var savebutton : Button
@export var loadbutton : Button


var playerHighscore : Highscore

func _ready():
      playerHighscore = Highscore.new("0",filemanager.load_game_get_playername(),0)

      button01.connect("pressed", _on_button_ArrowA)
      button02.connect("pressed", _on_button_ArrowB)
      button03.connect("pressed", _on_button_ArrowC)
      button04.connect("pressed", _on_button_ArrowD)

      savebutton.connect("pressed", _on_button_SaveHighscore)
      loadbutton.connect("pressed", _on_button_LoadHighscore)

func _on_button_LoadHighscore():
      highscoreManager._get_leaderboards()
      print(highscoreManager._get_leaderboards())
      var county = 0
      for x in highscoreManager.highscore_Table:

            rankList[county].text=x.rank 
            playernameList[county].text  = x.playerID
            playerScoreList[county].text  = str(x.score)
            county += 1

func _on_button_SaveHighscore():
      highscoreManager._upload_score(playerHighscore.score)


func _on_button_ArrowA():
      playerHighscore.score +=1
      scoreUI.text = str(playerHighscore.score)
func _on_button_ArrowB():
      playerHighscore.score +=10
      scoreUI.text = str(playerHighscore.score)
func _on_button_ArrowC():
      playerHighscore.score -=1
      scoreUI.text = str(playerHighscore.score)
func _on_button_ArrowD():
      playerHighscore.score -=10
      scoreUI.text = str(playerHighscore.score)





func _on_current_score_text_changed(new_text):
      playerHighscore.score  = int(new_text)
