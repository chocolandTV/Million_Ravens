extends Node

@export var feather_attack_scene: PackedScene
@export var mutti : CharacterBody2D
@onready var timer :Timer = $Timer
@onready var player = get_tree().get_first_node_in_group("player") as Node2D
@onready var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")

func _ready():
      timer.timeout.connect(on_timer_timeout)
func feather_spawn():
      if player == null:
            return
      var feather_instance = feather_attack_scene.instantiate() as CharacterBody2D
      foreground_layer.add_child(feather_instance)
      feather_instance.global_position = mutti.global_position


func on_timer_timeout():
      feather_spawn()
