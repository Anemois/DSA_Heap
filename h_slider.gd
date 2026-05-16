extends HSlider

func _on_value_changed(value: float) -> void:
	SignalBus.stimulation_speed = value
