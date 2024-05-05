extends Node
class_name arena_time_manager
@export var end_screen_scene: PackedScene
@export var myHighscoreEntry : PackedScene
@export var deltaTimer : ArenaDeltaTimer

@onready var timer = $Timer

var text : String ="You win: The Ravenlord has fallen"
var raven_lords_collected :int = 0
@export var raven_lords_max : int = 4

func _ready():
      timer.timeout.connect(on_timer_timeout)
      GameEvents.winGame_boss_down.connect(on_boss_down)
      GameEvents.get_leaderboards_is_finished.connect(win_game_highscore_fill)
      GameEvents.win_game_highscore_show_after_signal.connect(show_highscore)

func get_time_elapsed():
      return timer.wait_time - timer.time_left

func get_delta_time():
      return deltaTimer.time

func on_timer_timeout():
      text="You lose: 60 minutes done"
      GameEvents.player_died.emit()

func on_boss_down():
      raven_lords_collected +=1
      if raven_lords_collected >=raven_lords_max:
            #Win Condition defeat 4 ravenlords
            win_game()
      else:
            #region cleared
            GameEvents.winGame_region_cleared.emit()

func win_game():
      # Upload Current Score
      var metadata :String = str(deltaTimer.get_formated_time_elapsed()) +"," + str(Highscore_Manager.current_feathers) + "," + str(Highscore_Manager.current_coins)
      HighscoreUiSystem._upload_score(Highscore_Manager.current_highscore,metadata)
      #update Leaderboard and get player index as new Highscore_entry Panel
      HighscoreUiSystem._get_leaderboards()
func show_highscore():
      # Wait for signal then cast win_game_highscore_show_after_signal()
      var end_screen_instance = end_screen_scene.instantiate() as CanvasLayer
      add_child(end_screen_instance)
      end_screen_instance.setText(text)
      File_Manager.save_game()

func win_game_highscore_fill():
      for x in HighscoreUiSystem.highscore_Table:
            if x.playername == GlobalVariables.gv_Settings["player_name"]:
                  print("Game Win Debug: Player found, create Entry for Highscore")
                  var playerUIHighscore = myHighscoreEntry.instantiate()
                  add_child(playerUIHighscore)
                  playerUIHighscore.on_initialize_text(x.rank,x.playername,x.score,x.time,x.feather,x.coins)