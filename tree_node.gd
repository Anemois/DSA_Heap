class_name TreeNode extends Node2D

var assigned_position : Vector2
var move_rate: float = SignalBus.stimulation_speed * 0.1

func _ready() -> void:
	position = Vector2(0, 5000)

func _process(delta: float) -> void:
	move()

func move() -> void:
	position = position + (assigned_position - position) * move_rate

func relocate(x: float, y: float) -> void:
	assigned_position = Vector2(x,  y)

func teleport(x: float, y: float) -> void:
	assigned_position = Vector2(x, y)
	position = assigned_position

func set_value(v: int) -> void:
	$Label.text = str(v)

func get_assigned_position() -> Vector2:
	return assigned_position

func get_value() -> int:
	return int($Label.text)
