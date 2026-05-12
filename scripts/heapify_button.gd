extends Button
@onready var main: Node2D = $"../../../.."

func _on_pressed() -> void:
	main.heapify_button_pressed.emit()
