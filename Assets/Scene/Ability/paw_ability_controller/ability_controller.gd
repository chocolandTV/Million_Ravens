extends Node

@onready var settings : Global_Variables = get_node("/root/GlobalVariables")
@onready var timer : Timer  =$Timer
@export var right_paw_ability: PackedScene
var damage = 5
var base_wait_time
var camera_node : Camera2D
var isCooldown :bool  = false
const BASEDAMAGE = 5

func _ready():
      base_wait_time = $Timer.wait_time
      timer.timeout.connect(on_timer_timeout)
      GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
      camera_node = get_tree().get_first_node_in_group("camera") as Camera2D

func _input(event):
      if event.is_action_pressed("left_attack"):
            main_paw_attack()

func main_paw_attack():
      if isCooldown:
            return
      isCooldown = true
      var player = get_tree().get_first_node_in_group("player") as Node2D
      if player == null:
            return
      
      var paw_instance = right_paw_ability.instantiate() as PawAbility
      var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
      foreground_layer.add_child(paw_instance)
      paw_instance.hitbox_component.damage = damage
      
      var camera_offset:Vector2 = camera_node.get_local_mouse_position() + camera_node.global_position
      paw_instance.global_position = camera_offset
      paw_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

      var direction = paw_instance.global_position - paw_instance.global_position
      paw_instance.rotation = direction.angle()

      SoundManager.Emit_Sound(SoundManager.soundType.s_player_attack_sounds,Vector2.ZERO)

func on_timer_timeout():
      isCooldown = false
      #GAME EVENT ABILITY 1 MAIN IS ACTIVE
      # GameEvents.emit_ability_status_changed(0,true)

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