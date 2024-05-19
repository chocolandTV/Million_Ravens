extends CharacterBody2D

var unique_coin_collected :bool = false
@export var coin_fly_effect :PackedScene
@onready var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")

func _ready():
      $Area2D.area_entered.connect(on_area_entered)
func spawn_coin_effect():
      var _temp = coin_fly_effect.instantiate() as Node2D
      foreground_layer.add_child(_temp)
      _temp.global_position = global_position

      
func on_area_entered(other_area : Area2D):
      if !unique_coin_collected:
            print("shit")
            unique_coin_collected = true
            GameEvents.highscore_coin_collected.emit()
            spawn_coin_effect()
            queue_free()