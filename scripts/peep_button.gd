extends Button
@onready var main: Node2D = $"../../../.."

func _on_pressed() -> void:
	main.peep_button_pressed.emit()
