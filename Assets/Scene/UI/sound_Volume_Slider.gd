extends HSlider


func _on_value_changed(_value:float):
	GameEvents.menu_sound_volume_change.emit(2,_value)