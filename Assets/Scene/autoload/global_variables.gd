extends Node

class_name Global_Variables
const LUCKY_VALUE :int = 500
var gv_Settings = {
      "setting_volume_master" : 0.5,
      "setting_volume_sound" : 0.5,
      "setting_volume_music" : 0.5,
      "setting_volume_ambience":0.5,
      "offline_modus" : 0,
      "player_name" : "Player_Default",
      "player_identifier": "",
      "game_version" : "1",
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
func _ready():
      pass
func _on_timer_timeout():
      newLuckyInt()

func get_lucky_catmint_value():
      if gv_lucky_catmint == 500:
            print("LUCKY EVENT")
            newLuckyInt()
            increase_multiplier()
            return LUCKY_VALUE
      return gv_lucky_catmint

func newLuckyInt():
      gv_lucky_catmint = randi_range(0,1000)

func increase_multiplier():
      gv_score_multiplier += 1
func reset_multiplier():
      gv_score_multiplier = 1