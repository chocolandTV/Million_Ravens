extends Node


@onready var splash = $%firstSplash
@onready var menu = $%Menu
@onready var playername_textField : LineEdit = $%LineEdit
@onready var setting_menu : MarginContainer = $%Setting_Menu

@onready var global_vars : Global_Variables = get_node("/root/GlobalVariables")
@onready var highscore_ui_system : HighscoreUISystem = get_node("/root/HighscoreUiSystem")

var setting_enabled :bool = false
func _ready():
      playername_textField.text_submitted.connect(on_playername_textfield_submitted)
func _on_timer_timeout():
      splash.visible = false
      menu.visible = true


func _on_quit_button_pressed():
      get_tree().quit()

func _on_start_button_pressed():
      get_tree().change_scene_to_file("res://Assets/Scene/main.tscn")


func _on_button_highscore_pressed():
      get_tree().change_scene_to_file("res://Assets/Scene/UI/highscore_menu.tscn")


func _on_button_pressed():
      on_playername_textfield_submitted(playername_textField.text)

func on_playername_textfield_submitted(_text : String):
      global_vars.gv_Settings["player_name"]  = _text
      highscore_ui_system._change_player_name(_text)
      


func _on_button_settings_pressed():
      toggleSettingMenu()

func toggleSettingMenu():
      setting_enabled = !setting_enabled
      setting_menu.visible = setting_enabled
