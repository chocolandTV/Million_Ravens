extends Node

@export var mainpaw_ability: PackedScene
@export var damage = 5

var max_attack_range = 150
var isCooldown :bool  = false
var cooldown_attack : float = 1
var camera_node : Camera2D

func _ready():
      $Timer.timeout.connect(on_timer_timeout)
      camera_node = get_tree().get_first_node_in_group("camera") as Camera2D

func _input(event):
      if event.is_action_pressed("attack"):
            main_paw_attack()

func cooldown_update(value : float):
      cooldown_attack -= value
      $Timer.wait_time = cooldown_attack
      
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
