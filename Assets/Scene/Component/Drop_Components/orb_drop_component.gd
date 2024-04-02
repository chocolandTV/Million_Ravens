extends Node

@export var orb_Scene : PackedScene
@export var feather_Scene : PackedScene
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
      var random_a : int = randi_range(0,100)
      var orb_instance
      if random_a >95:
            orb_instance = feather_Scene.instantiate() as Node2D
            print("feather rolled :", random_a)
      else:
            orb_instance = orb_Scene.instantiate() as Node2D
            print("highscore orb rolled :", random_a)
      var entities_layer = get_tree().get_first_node_in_group("entities_layer")
      if highscore_amount == 1000:
            GameEvents.emit_highscore_orb_collected(highscore_amount)
      entities_layer.add_child(orb_instance)
      orb_instance.global_position = spawn_position