extends Button

@onready var insert_text = $"../Input"
var disabled_style = $".".get_theme_stylebox("disabled")

func _ready() -> void:
	disabled_style.bg_color = Color(0.259, 0.259, 0.259, 1.0)
	SignalBus.peep_button_pressed.connect(lock)
	SignalBus.pop_button_pressed.connect(lock)
	SignalBus.insert_button_pressed.connect(lock)
	SignalBus.insert_button_pressed.connect(be_selected)

func _on_pressed() -> void:
	var value = insert_text.text
	insert_text.clear()
	if(value.is_valid_int()):
		value = int(value)
	elif(value.is_empty()):
		value = randi_range(1, 999)
	else:
		return
	if(0<value and value<1000):
		SignalBus.insert_button_pressed.emit(value)

func lock(value: int):
	disabled = true
	await SignalBus.processes_all_finished
	disabled = false

func be_selected(value: int):
	disabled_style.bg_color = Color(0.941, 0.714, 0.325, 1.0)
	await SignalBus.processes_all_finished
	disabled_style.bg_color = Color(0.259, 0.259, 0.259, 1.0)
