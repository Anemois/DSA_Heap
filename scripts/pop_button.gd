extends Button

func _on_pressed() -> void:
	SignalBus.pop_button_pressed.emit()
