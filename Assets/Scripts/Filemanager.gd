extends Node

class_name Filemanager
const SAVE_PATH : String = "user://funny.bin"
const SAVE_PASS : String = "iHWgc%d8g2V="
@onready var settings : Global_Settings = get_node("/root/GlobalSetting")




func save_game() -> void:
      var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
      var jstr = JSON.stringify(settings.globalSetting)
      file.store_line(jstr)
      print ("Data Saved to User.")
      file.close()

func load_game() -> void:
      var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
      if not file:
            return
      if file == null:
            return
      if FileAccess.file_exists(SAVE_PATH) == true:
            if not file.eof_reached():
                  var current_line =JSON.parse_string(file.get_line())
                  if current_line:
                        settings.globalSetting = current_line

      file.close()

func load_game_get_playername():
      var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
      if not file:
            return
      if file == null:
            return
      if FileAccess.file_exists(SAVE_PATH) == true:
            if not file.eof_reached():
                  var current_line =JSON.parse_string(file.get_line())
                  if current_line:
                        settings.globalSetting = current_line

      file.close()
      return settings.globalSetting["player_identifier"]