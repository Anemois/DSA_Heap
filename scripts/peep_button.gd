extends Button

func _on_pressed() -> void:
	SignalBus.peep_button_pressed.emit()
