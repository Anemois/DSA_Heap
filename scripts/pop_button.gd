extends Button

var disabled_style = $".".get_theme_stylebox("disabled")

func _ready() -> void:
	disabled_style.bg_color = Color(0.259, 0.259, 0.259, 1.0)
	SignalBus.peep_button_pressed.connect(lock)
	SignalBus.pop_button_pressed.connect(lock)
	SignalBus.insert_button_pressed.connect(lock)
	SignalBus.pop_button_pressed.connect(be_selected)

func _on_pressed() -> void:
	SignalBus.pop_button_pressed.emit(0)

func lock(value: int):
	disabled = true
	await SignalBus.processes_all_finished
	disabled = false

func be_selected(value: int):
	disabled_style.bg_color = Color(0.941, 0.714, 0.325, 1.0)
	await SignalBus.processes_all_finished
	disabled_style.bg_color = Color(0.259, 0.259, 0.259, 1.0)
