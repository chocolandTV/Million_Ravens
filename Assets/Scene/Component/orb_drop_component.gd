extends Node

@export var orb_Scene : PackedScene
@export var highscore_amount : int
@export var health_component : Node

func _ready():
      ( health_component as HealthComponent).died.connect(on_died)

func on_died():
      if orb_Scene == null:
            return
      if not owner is Node2D:
            return
      var spawn_position = (owner as Node2D).global_position
      var orb_instance = orb_Scene.instantiate() as Node2D
      owner.get_parent().add_child(orb_instance)
      orb_instance.global_position = spawn_position