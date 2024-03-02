extends LineEdit


@onready var settings : Global_Settings = get_node("/root/GlobalSetting")
@onready var highscoreManager : HighscoreSystem  = get_node("/root/HighscoreManager")



func _on_text_changed(new_text:String):
      settings.globalSetting["player_identifier"]= new_text




func _on_text_submitted(new_text:String):
      highscoreManager._change_player_name(new_text)
