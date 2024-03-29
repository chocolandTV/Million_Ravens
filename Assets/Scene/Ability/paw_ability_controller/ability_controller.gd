extends Node

@onready var settings : Global_Variables = get_node("/root/GlobalVariables")
@onready var timer : Timer  =$Timer
@export var paw_ability: PackedScene
@export var damage = 5
var base_wait_time

const BASEDAMAGE = 5
const MAX_RANGE = 150

func _ready():
      base_wait_time = $Timer.wait_time
      timer.timeout.connect(on_timer_timeout)
      GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)



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
      var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
      foreground_layer.add_child(paw_instance)
      paw_instance.hitbox_component.damage = damage

      paw_instance.global_position = enemies[0].global_position
      paw_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

      var enemy_direction = enemies[0].global_position - paw_instance.global_position
      paw_instance.rotation = enemy_direction.angle()

func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
      if upgrade.id == "paw_attack_damage":
            on_upgrade_damage(current_upgrades["paw_attack_damage"]["quantity"])

      if upgrade.id == "attack_speed":
             on_upgrade_cooldown(current_upgrades["attack_speed"]["quantity"])

func on_upgrade_cooldown(quantity : float):
      var percent_reduction = quantity* .1
      settings.gv_Settings["paw_ability_cooldown_level"] = (1- percent_reduction)
      if percent_reduction > 0.99:
            percent_reduction = 0.99
      timer.wait_time = (1- percent_reduction)
      timer.start()
func on_upgrade_damage(quantity : float):
      var new_damage =  BASEDAMAGE + quantity

      settings.gv_Settings["paw_ability_damage_level"] = new_damage

      damage = new_damage