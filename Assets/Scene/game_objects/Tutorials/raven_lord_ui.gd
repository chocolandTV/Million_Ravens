extends Node2D
@onready var progressbar : ProgressBar =$HealthBar
@onready var sprite : AnimatedSprite2D = $Node2D/AnimatedSprite2D

func on_region_collect_raven(_value : float):
      if _value >0.5:
            sprite.set_frame(1)
      if _value >0.7:
            sprite.set_frame(2)
      if _value >0.9:
            sprite.set_frame(3)
      
      progressbar.value = _value