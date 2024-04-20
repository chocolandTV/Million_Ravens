extends Node

class_name FileManager

const SAVE_PATH : String ="user://funny.bin"

@onready var settings : Global_Variables = get_node("/root/GlobalVariables")

func save_game() -> void:
      var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
      var jstr = JSON.stringify(settings.gv_Settings)
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
                        settings.gv_Settings = current_line
                        # load audio volumes
                        load_audio_savedata()

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
                        settings.gv_Settings = current_line

      file.close()
      return settings.gv_Settings["player_name"]

func load_audio_savedata():
      pass
      # GameEvents.emit_menu_sound_volume_change(0, settings.gv_Settings["setting_volume_master"])
      # GameEvents.emit_menu_sound_volume_change(1, settings.gv_Settings["setting_volume_music"])
      # GameEvents.emit_menu_sound_volume_change(2, settings.gv_Settings["setting_volume_sound"])
      # GameEvents.emit_menu_sound_volume_change(3, settings.gv_Settings["setting_volume_ambience"])
