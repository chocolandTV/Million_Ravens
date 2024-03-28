extends ParallaxLayer
@export var Cloud_Speed  : float = -15

func _process(delta) -> void :
      self.motion_offset.x += Cloud_Speed * delta