extends Button

@onready var insert_text = $"../Input"

func _on_pressed() -> void:
	var value = insert_text.text
	insert_text.clear()
	if(value.is_valid_int()):
		value = int(value)
	elif(value.is_empty()):
		value = randi_range(1, 99)
	else:
		return
	if(0<value and value<100):
			SignalBus.insert_button_pressed.emit(value)
