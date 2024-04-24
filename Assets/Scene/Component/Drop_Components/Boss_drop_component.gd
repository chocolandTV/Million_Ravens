extends Node

@export var highscore_amount : int
@export var health_component : Node

func _ready():
      ( health_component as HealthComponent).died.connect(on_died)

func on_died(_type: int):
      GameEvents.highscore_orb_collected.emit(highscore_amount)
      GameEvents.winGame_boss_down_event.emit()
