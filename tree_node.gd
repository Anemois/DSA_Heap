extends Node2D

var assigned_position : Vector2
const move_rate: float = 0.5

func _ready() -> void:
	position = assigned_position

func _process(delta: float) -> void:
	position = position + (assigned_position - position) * move_rate

func relocate(x: float, y: float) -> void:
	assigned_position = Vector2(x,  y)

func set_value(v: int) -> void:
	$Label.text = str(v)

func get_assigned_position() -> Vector2:
	return assigned_position

func get_value() -> int:
	return int($Label.text)
