extends Node

@export var end_screen_scene: PackedScene
@export var myHighscoreEntry : PackedScene

@onready var timer = $Timer
@onready var highscore_ui_system : HighscoreUISystem = get_node("/root/HighscoreUiSystem")
@onready var highscore_manager : Highscore_Manager = get_node("/root/Highscore_Manager")
@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")

var text : String ="You win: You survived 10 minutes"
func _ready():
      timer.timeout.connect(on_timer_timeout)
      GameEvents.winGame_boss_down.connect(on_boss_down)


func get_time_elapsed():
      return timer.wait_time - timer.time_left

func on_timer_timeout():
      text="You win: You survived 10 minutes"
      win_game()

func on_boss_down():
      text="the Ravenlord has fallen, good job"
      win_game()

func win_game():
      # Upload Current Score
      highscore_ui_system._upload_score(highscore_manager.current_highscore)
      #update Leaderboard and get player index as new Highscore_entry Panel
      highscore_ui_system._get_leaderboards()
      for x in highscore_ui_system.highscore_Table:
            if x.playername == globalVars.gv_Settings["player_name"]:
                  print("Game Win Debug: Player found, create Entry for Highscore")
                  var playerUIHighscore = myHighscoreEntry.instantiate()
                  add_child(playerUIHighscore)
                  playerUIHighscore.on_initialize_text(x.rank,x.playername,x.score,x.time,x.feather,x.coins)

      var end_screen_instance = end_screen_scene.instantiate() as CanvasLayer
      add_child(end_screen_instance)
      end_screen_instance.setText(text)