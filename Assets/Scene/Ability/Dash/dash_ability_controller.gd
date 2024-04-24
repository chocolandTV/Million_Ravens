extends Node


@onready var timer :Timer = $Timer
@export var player :CharacterBody2D
var isCooldown :bool = false

func _ready():
      timer.timeout.connect(on_timer_timeout)
func _input(event):
      if event.is_action_pressed("dash"):
            dashing()

func on_timer_timeout():
      isCooldown = false

func dashing():
      if isCooldown:
            return
      isCooldown =true
      timer.start()
      player.player_dash()
      #animate