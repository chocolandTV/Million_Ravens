extends CharacterBody2D
func _ready():
      $Area2D.area_entered.connect(on_area_entered)

func on_area_entered(other_area : Area2D):
      GameEvents.highscore_feather_collected.emit()

      queue_free()