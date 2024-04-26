extends CanvasLayer

@onready var vbox_container : VBoxContainer = $%VBoxContainer

@export var highscore_entry : PackedScene

var highscorelist : Array[Panel]
func _ready():
      @warning_ignore("integer_division")

func on_CanvasLayer_activate():
      #Delete old leaderboard
      for x in highscorelist:
            x.queue_free()
      highscorelist.clear()
      #GET HIGHSCORE DATA
      HighscoreUiSystem._get_leaderboards()
      for x in HighscoreUiSystem.highscore_Table:
            # INSTANTIATE AS PANEL AND AD IN TABLE
            var score_entry = highscore_entry.instantiate() as Panel
            vbox_container.add_child(score_entry)
            highscorelist.append(score_entry)
            # ADD DATA TO HIGHSCORE ENTRY 
            score_entry.on_initialize_text(x.rank, x.playername, x.score, format_milliseconds(x.time), x.feather, x.coins)
      # CREATE ENTRY FOR EACH HIGHSCORE 
func _on_button_pressed():
      # CHANGE to INSTANCE VISIBLE OFF
      get_tree().change_scene_to_file("res://Assets/Scene/main/main_menu.tscn")

func format_milliseconds(text :String):
      var time = int(float(text))
      #millseconds calculated: time mod 1000
      var msec = time%1000
      # ZwischenStep #01 convert time seconds : time /1000 int
      time = time / 1000
      # sekunden ausrechnen  time mod 60
      var secs = time%60
      # Zwischenstep 02 convert time minutes :  time / 60 int
      time = time /60
      #minuten ausrechnen time mod 60 
      var mins = time%60
      # Zwischenstep 03 convert time hours:  time / 60 int
      time = time /60
      #stunden ausrechnen time mod 24
      var hr = time%24
      # Zwischenstep 04 convert time days:  time / 24 int
      text = "%02dh%02dm%02ds%03dms" % [hr,mins,secs,msec]
      return text
