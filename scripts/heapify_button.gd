extends Button

func _on_pressed() -> void:
	SignalBus.heapify_button_pressed.emit()

func _process(delta: float) -> void:
	if SignalBus.changed_from_menu:
		SignalBus.changed_from_menu = false
		SignalBus.heapify_button_pressed.emit(0)
