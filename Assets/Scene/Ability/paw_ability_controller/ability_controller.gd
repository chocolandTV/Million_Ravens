extends Node

@export var paw_ability: PackedScene
@export var damage = 5

const MAX_RANGE = 150

func _ready():
      $Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():

      var player = get_tree().get_first_node_in_group("player") as Node2D
      if player == null:
            return
      var enemies = get_tree().get_nodes_in_group("enemy")
      enemies = enemies.filter(func(enemy: Node2D):
            return enemy.global_position.distance_squared_to(player.global_position) < pow (MAX_RANGE, 2)
            )
      if enemies.size() == 0:
            return

      enemies.sort_custom(func(a: Node2D, b: Node2D):
            var a_distance = a.global_position.distance_squared_to(player.global_position)
            var b_distance = b.global_position.distance_squared_to(player.global_position)
            return a_distance < b_distance
      )
      var paw_instance = paw_ability.instantiate() as PawAbility
      player.get_parent().add_child(paw_instance)
      paw_instance.hitbox_component.damage = damage

      paw_instance.global_position = enemies[0].global_position
      paw_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

      var enemy_direction = enemies[0].global_position - paw_instance.global_position
      paw_instance.rotation = enemy_direction.angle()