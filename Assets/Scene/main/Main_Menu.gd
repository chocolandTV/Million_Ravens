extends Node


@onready var splash = $%firstSplash
@onready var menu = $%Menu



func _on_timer_timeout():
      splash.visible = false
      menu.visible = true


func _on_quit_button_pressed():
      get_tree().quit()

func _on_start_button_pressed():
      get_tree().change_scene_to_file("res://Assets/Scene/main.tscn")


func _on_button_highscore_pressed():
      get_tree().change_scene_to_file("res://Assets/Scene/UI/highscore_menu.tscn")
