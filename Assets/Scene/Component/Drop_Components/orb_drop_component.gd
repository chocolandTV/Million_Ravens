extends Node

@export var orb_Scene : PackedScene
@export var feather_Scene : PackedScene
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
      var globalVars : Global_Variables = get_node("/root/GlobalVariables")
      var orb_instance
      if globalVars.get_lucky_catmint_value() == 500:
            orb_instance = feather_Scene.instantiate() as Node2D
      else:
            orb_instance = orb_Scene.instantiate() as Node2D
      var entities_layer = get_tree().get_first_node_in_group("entities_layer")
      if highscore_amount == 1000:
            GameEvents.highscore_orb_collected.emit(highscore_amount)
      entities_layer.add_child(orb_instance)
      orb_instance.global_position = spawn_position