extends Node

class_name Global_Variables
const LUCKY_VALUE :int = 500
var temp_score_multiplier = 0
var luckyEvent_timer = 0 
var gv_Settings = {
      "setting_volume_master" : 0.5,
      "setting_volume_sound" : 0.5,
      "setting_volume_music" : 0.5,
      "setting_volume_ambience":0.5,
      "offline_modus" : 0,
      "player_name" : "Player_Default",
      "player_identifier": "",
      "game_version" : "1.0",
#Game settings
      "raven_lords_max" : 4,
#ability settings
      "paw_ability_damage_level" : 1,
      "paw_ability_cooldown_level" : 0.01,
      "player_movement_speed_level" : 150,
      "player_health_level" : 1
}
var gv_lucky_catmint: int = 1000
# multiplier will increase every Score +
# get signal by game_events
var gv_score_multiplier : int = 1
# func _ready():
#       GameEvents.menu_start_game.connect(luckyEvent_Start)

func _on_timer_timeout():
      newLuckyInt()
      # CHECK IF EVEN IS RUNNING 
      if temp_score_multiplier > 0:
            luckyEvent_timer += 1
      # STOP LUCKY EVENT
      if luckyEvent_timer >= 5:
            print("LuckyEvent: Stopped")
            GameEvents.lucky_event.emit(false)
            gv_score_multiplier = temp_score_multiplier
            temp_score_multiplier = 0

func get_lucky_catmint_value():
      if gv_lucky_catmint == 500:
            print("LUCKY EVENT")
            newLuckyInt()
            return LUCKY_VALUE
      return gv_lucky_catmint

func newLuckyInt():
      gv_lucky_catmint = randi_range(0,1000)
      if gv_lucky_catmint == 500:
            print("LUCKY EVENT")
            luckyEvent_Start()

func increase_multiplier():
      gv_score_multiplier += 1
func reset_multiplier():
      gv_score_multiplier = 1

func luckyEvent_Start():
      #START EVENT
      print("LuckyEvent: Started")
      GameEvents.lucky_event.emit(true)
      temp_score_multiplier = gv_score_multiplier
      gv_score_multiplier = 500
