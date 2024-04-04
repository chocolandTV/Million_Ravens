extends Node

class_name Global_Variables
const LUCKY_VALUE :int = 500
var gv_Settings = {
      "setting_volume_master" : 0.5,
      "setting_volume_sound" : 0.5,
      "setting_volume_music" : 0.5,
      "offline_modus" : 0,
      "player_name" : "Player_Default",
      "player_identifier": "",
      "game_version" : "1.00",
#ability settings
      "paw_ability_damage_level" : 1,
      "paw_ability_cooldown_level" : 0.01,
      "player_movement_speed_level" : 150,
      "player_health_level" : 1
}
var gv_lucky_catmint: int = 0


func _on_timer_timeout():
      luckyshuffle()

func get_lucky_catmint_value():
      if gv_lucky_catmint == 500:
            luckyshuffle()
            return LUCKY_VALUE
      return gv_lucky_catmint

func luckyshuffle():
      gv_lucky_catmint = randi_range(0,1000)
