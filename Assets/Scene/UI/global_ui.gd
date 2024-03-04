extends CanvasLayer

@onready var highscore_value_text : Label = $%Value_Highscore
@onready var value_fps_text : Label =$%Value_FPS

@export var highscoremanager : HighscoreManager

func _process(delta):
      value_fps_text.text = ("FPS: %d" % Engine.get_frames_per_second())
      highscore_value_text.text = str(highscoremanager.current_highscore)