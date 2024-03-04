extends StaticBody2D
class_name Region_Text_Class

@export var region_text : String

func _ready():
      $%Label.text = region_text

func get_region_text():
      return region_text

func set_region_text(_text : String):
      region_text = _text