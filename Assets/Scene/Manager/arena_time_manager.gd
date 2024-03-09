extends Node

@export var end_screen_scene: PackedScene

@onready var timer = $Timer
var text : String ="You win: You survived 10 minutes"
func _ready():
      timer.timeout.connect(on_timer_timeout)
      GameEvents.winGame_boss_down.connect(on_boss_down)


func get_time_elapsed():
      return timer.wait_time - timer.time_left

func on_timer_timeout():
      text="You win: You survived 10 minutes"
      win_game()

func on_boss_down():
      text="the Ravenlord has fallen, good job"
      win_game()

func win_game():
      var end_screen_instance = end_screen_scene.instantiate() as CanvasLayer
      add_child(end_screen_instance)
      end_screen_instance.setText(text)