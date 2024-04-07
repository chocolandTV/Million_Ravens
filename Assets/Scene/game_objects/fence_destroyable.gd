extends Node2D

@onready var player_health_comonent : HealthComponent = $HealthComponent
@onready var player_animations : AnimatedSprite2D = $AnimatedSprite2D


func _ready():
      player_health_comonent.died.connect(on_fence_died)
      player_health_comonent.health_changed.connect(on_fence_damaged)

func on_fence_died():
      pass
func on_fence_damaged():
      pass
