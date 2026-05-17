extends HSlider

func _ready() -> void:
	self.value = SignalBus.stimulation_speed

func _on_value_changed(value: float) -> void:
	if value <= 1:
		SignalBus.stimulation_speed = value
	else:
		SignalBus.stimulation_speed = value ** 2
