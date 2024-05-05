extends Node

@export var orb_Scene : PackedScene
@export var highscore_amount : int
@export var health_component : Node

func _ready():
      ( health_component as HealthComponent).died.connect(on_died)

func on_died(_type: int):
      if orb_Scene == null:
            return
      if not owner is Node2D:
            return
      var spawn_position = (owner as Node2D).global_position
      var orb_instance
      orb_instance = orb_Scene.instantiate() as Node2D
      var entities_layer = get_tree().get_first_node_in_group("entities_layer")
      if highscore_amount == 1000:
            GameEvents.highscore_orb_collected.emit(highscore_amount)
      entities_layer.add_child(orb_instance)
      orb_instance.global_position = spawn_position