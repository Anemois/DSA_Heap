extends Control
@onready var random_array_size: LineEdit = $VBoxContainer/HBoxContainer/RandomArraySize

func _on_empty_array_pressed() -> void:
	SignalBus.preloaded_array = []
	SignalBus.changed_from_menu = true
	get_tree().change_scene_to_file("res://main.tscn")

func _on_random_array_pressed() -> void:
	SignalBus.preloaded_array = []
	SignalBus.changed_from_menu = true
	var value = random_array_size.text
	random_array_size.clear()
	if(value.is_valid_int()):
		value = int(value)
		var array: Array[int] = []
		for i in range(value):
			array.append(randi_range(1, 999))
		SignalBus.preloaded_array = array
		get_tree().change_scene_to_file("res://main.tscn")

func _on_create_array_pressed() -> void:
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/credits.tscn")
