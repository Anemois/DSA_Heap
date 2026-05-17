extends HSlider

func _ready() -> void:
	self.value = SignalBus.stimulation_speed

func _on_value_changed(value: float) -> void:
	var prev_value = SignalBus.stimulation_speed
	if value <= 1:
		SignalBus.stimulation_speed = value
		SignalBus.change_timer_ratio(prev_value / value)
	elif value < 4:
		SignalBus.stimulation_speed = value ** 2
		SignalBus.change_timer_ratio(prev_value / (value ** 2))
	else:
		SignalBus.stimulation_speed = 20
		SignalBus.change_timer_ratio(prev_value / (20))
