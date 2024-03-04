extends Node2D
@export var end_screen_scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$%HighscoreManager.highscore_died.connect(on_highscore_died)


func on_highscore_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()