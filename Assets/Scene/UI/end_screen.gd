extends CanvasLayer

@export var highscore_panel: PackedScene
@onready var filemanager : FileManager = get_node("/root/File_Manager")
@onready var highscore_manager : Highscore_Manager = get_node("/root/Highscore_Manager")
@onready var timer :Timer = $%Timer
@onready var restartButton : Button = $%RestartButton
@onready var quitButton : Button = $%QuitButton
@onready var highscoreButton : Button =$%HighscoreButton
# Called when the node enters the scene tree for the first time.
func _ready():
	
	restartButton.pressed.connect(on_restart_button_pressed)
	quitButton.pressed.connect(on_quit_button_pressed)
	highscoreButton.pressed.connect(on_highscore_button_pressed)
	timer.timeout.connect(on_timer_timeout)
	get_tree().paused = true

func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You have no health left"
# set text after winning
func setText(_text : String):
	$%TitleLabel.text = "Victory"
	$%DescriptionLabel.text = _text
	#if HIGHSCORE IS BETTER  : 
	#$%newHighscoreLabel.text = "+New highscore!"
	$CPUParticles2D.emitting = true

func on_restart_button_pressed():
	filemanager.save_game()
	highscore_manager.on_highscore_reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scene/main/main.tscn")
	
func on_quit_button_pressed():
	filemanager.save_game()
	get_tree().quit()

func on_highscore_button_pressed():
	filemanager.save_game()
	#hide menu
	# get_tree().paused = false
	visible = false
	#Instantiate Highscore
	GameEvents.highscore_button_pressed.emit()

func on_timer_timeout():
	#enable all buttons
	
	restartButton.disabled = false
	quitButton.disabled = false
	highscoreButton.disabled = false