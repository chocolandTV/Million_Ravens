extends CharacterBody2D

var animation_is_finished :bool = false
@onready var player_node = get_tree().get_first_node_in_group("player") as Node2D
var speed :float = 500

func on_animation_done():
      animation_is_finished = true

func _process(_delta):
      #get direction
      if !animation_is_finished:
            return
      var direction = get_direction_to_player()
      #start flying
      velocity = direction * speed
      speed -= _delta
      if speed <1:
            queue_free()
      if player_node.global_position.distance_to(global_position) <10:
            GameEvents.highscore_orb_collected.emit(1)
            queue_free()

      move_and_slide()

func get_direction_to_player():
      #get player
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      return Vector2.ZERO
