extends Node

@export var highscore_amount : int
@export var health_component : Node

func _ready():
      ( health_component as HealthComponent).died.connect(on_died)

func on_died():
      GameEvents.emit_highscore_orb_collected(highscore_amount)
