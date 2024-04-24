extends HSlider


func _on_value_changed(_value:float):
	GameEvents.menu_sound_volume_change.emit(0,_value)
