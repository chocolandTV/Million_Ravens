extends Node2D
@onready var settings : Global_Settings = get_node("/root/GlobalSetting")


func _on_area_2d_body_entered(body:Node2D):
      if body.is_in_group("player"):
            queue_free()
