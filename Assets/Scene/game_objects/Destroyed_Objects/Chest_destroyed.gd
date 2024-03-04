extends StaticBody2D

var region_text :String = ""

func set_region_text(_text : String):
      region_text = _text

func _on_timer_timeout():
      $%Label.text = ""
