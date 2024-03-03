extends Node2D
@export var highscore_amount : int =  1

func _ready():
      $Area2D.area_entered.connect(on_area_entered)

func on_area_entered(other_area : Area2D):
      GameEvents.emit_highscore_orb_collected(highscore_amount)
      queue_free()