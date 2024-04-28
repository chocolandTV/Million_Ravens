extends CanvasLayer

@onready var vbox_container : VBoxContainer = $%VBoxContainer

@export var highscore_entry : PackedScene

var highscorelist : Array[Panel]
func _ready():
      GameEvents.get_leaderboards_is_finished.connect(_wait_for_finished)

func on_CanvasLayer_activate():
      #Delete old leaderboard
      for x in highscorelist:
            x.queue_free()
      highscorelist.clear()
      #GET HIGHSCORE DATA
      HighscoreUiSystem._get_leaderboards()
func _wait_for_finished():
      for x in HighscoreUiSystem.highscore_Table:
            # INSTANTIATE AS PANEL AND AD IN TABLE
            var score_entry = highscore_entry.instantiate() as Panel
            vbox_container.add_child(score_entry)
            highscorelist.append(score_entry)
            # ADD DATA TO HIGHSCORE ENTRY 
            score_entry.on_initialize_text(x.rank, x.playername, x.score, x.time, x.feather, x.coins)
      # CREATE ENTRY FOR EACH HIGHSCORE 
func _on_button_pressed():
      # CHANGE to INSTANCE VISIBLE OFF
      get_tree().change_scene_to_file("res://Assets/Scene/main/main_menu.tscn")
