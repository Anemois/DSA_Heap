extends Button

func _on_pressed() -> void:
	var value = 3
	SignalBus.insert_button_pressed.emit(value)
