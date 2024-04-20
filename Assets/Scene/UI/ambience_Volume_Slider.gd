extends HSlider


func _on_value_changed(_value:float):
	GameEvents.emit_menu_sound_volume_change(3,_value)
