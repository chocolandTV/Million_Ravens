extends CanvasLayer

@onready var filemanager : FileManager = get_node("/root/GlobalFileManager")
@onready var settings : Global_Variables  =get_node("/root/GlobalVariables")
@onready var highscore_ui_system : HighscoreUISystem = get_node("/root/HighscoreUiSystem")
@onready var highscoremanager : HighscoreManager = get_node("/root/Highscore_Manager")

@onready var vbox_container : VBoxContainer = $%VBoxContainer

@export var highscore_entry : PackedScene

func _ready():
      # GET HIGHSCORE DATA
      highscore_ui_system._get_leaderboards()
      for x in highscore_ui_system.highscore_Table:
            # INSTANTIATE AS PANEL AND AD IN TABLE
            var score_entry = highscore_entry.instantiate() as Panel
            vbox_container.add_child(score_entry)
            # ADD DATA TO HIGHSCORE ENTRY 
            score_entry.on_initialize_text(x.rank, x.playername, x.score, x.time, x.feather, x.coins)
      # CREATE ENTRY FOR EACH HIGHSCORE 

func saveHighscore():
      highscore_ui_system. _upload_score(highscoremanager.current_highscore)

func _on_button_pressed():
      get_tree().change_scene_to_file("res://Assets/Scene/main/main_menu.tscn")

