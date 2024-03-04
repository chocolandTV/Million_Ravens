extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)

func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = " You have no Scorepoints left- it is your health"

func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scene/main.tscn")
	
func on_quit_button_pressed():
	get_tree().quit()