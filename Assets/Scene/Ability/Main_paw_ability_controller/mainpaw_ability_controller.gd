extends Node

@onready var globalVars : Global_Variables = get_node("/root/GlobalVariables")
@export var mainpaw_ability: PackedScene
var damage = 5

var max_attack_range = 150
var isCooldown :bool  = false
var cooldown_attack : float = 1
var camera_node : Camera2D

func _ready():
      $Timer.timeout.connect(on_timer_timeout)
      camera_node = get_tree().get_first_node_in_group("camera") as Camera2D
      GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

func _input(event):
      if event.is_action_pressed("attack"):
            main_paw_attack()

func main_paw_attack():
      if isCooldown:
            return
      isCooldown = true
      #GAME EVENT ABILITY 1 MAIN IS ACTIVE
      GameEvents.emit_ability_status_changed(0,false)

      var player = get_tree().get_first_node_in_group("player") as Node2D
      if player == null:
            return
      
      var paw_instance = mainpaw_ability.instantiate() as PawAbility
      var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
      foreground_layer.add_child(paw_instance)
      paw_instance.hitbox_component.damage = damage
      
      var camera_offset:Vector2 = camera_node.get_local_mouse_position() + camera_node.global_position
      paw_instance.global_position = camera_offset
      paw_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

      var direction = paw_instance.global_position - paw_instance.global_position
      paw_instance.rotation = direction.angle()

func on_timer_timeout():
      isCooldown = false
      #GAME EVENT ABILITY 1 MAIN IS ACTIVE
      GameEvents.emit_ability_status_changed(0,true)


func on_ability_upgrade_added(upgrade : AbilityUpgrade, current_upgrades: Dictionary):
      if upgrade.id == "paw_attack_damage":
            on_upgrade_damage(current_upgrades["paw_attack_damage"]["quantity"])

      if upgrade.id == "attack_speed":
             on_upgrade_cooldown(current_upgrades["attack_speed"]["quantity"])

func on_upgrade_cooldown(quantity : float):
      globalVars.gv_Settings[ "paw_ability_cooldown_level"]  =quantity
      var percent_reduction = clamp( quantity * .1, 0.1, 0.9)
      $Timer.wait_time = (1- percent_reduction)
      $Timer.start()
      print("Upgrade Attack_Cooldown :  ",percent_reduction)
func on_upgrade_damage(quantity : float):
      globalVars.gv_Settings[ "paw_ability_damage_level"]  =quantity
      damage *= quantity
      print("Upgrade Attack_Damage :  ", damage)