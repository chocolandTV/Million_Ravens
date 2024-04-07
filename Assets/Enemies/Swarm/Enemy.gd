extends CharacterBody2D
class_name Enemy_swarm
const speed : float  = 125.0
@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D

func _process(_delta):
      if !is_visible_in_tree():
            return
      var direction = get_direction_to_player()
      velocity = direction * speed
      move_and_slide()

func get_direction_to_player():
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      if player_node == null:
            player_node = get_tree().get_first_node_in_group("player") as Node2D
      return Vector2.ZERO
