extends Button

func _on_pressed() -> void:
	SignalBus.heapify_button_pressed.emit()
