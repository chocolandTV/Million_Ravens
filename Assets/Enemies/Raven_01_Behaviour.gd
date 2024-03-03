extends CharacterBody2D


@onready var health_component : HealthComponent = $HealthComponent
@export var speed :float  =225.0

func _process(_delta):
      #get direction
      var direction = get_direction_to_player()
      #start flying
      velocity = direction * speed
      move_and_slide()
      # increase speed

func get_direction_to_player():
      #get player
      var player_node = get_tree().get_first_node_in_group("player") as Node2D
      if player_node != null:
            return (player_node.global_position - global_position).normalized()
      #return if not null
      return Vector2.ZERO
