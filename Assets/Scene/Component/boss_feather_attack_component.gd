extends Node2D

@export var feather_attack_scene: PackedScene
@onready var timer :Timer = $Timer
var damage = 5

@onready var player = get_tree().get_first_node_in_group("player") as Node2D
@onready var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
func _ready():
      timer.timeout.connect(on_timer_timeout)
func feather_attack():
      if player == null:
            return
      var feather_instance = feather_attack_scene.instantiate() as PawAbility
      foreground_layer.add_child(feather_instance)
      feather_instance.hitbox_component.damage = damage
      feather_instance.global_position = global_position


func on_timer_timeout():
      feather_attack()
