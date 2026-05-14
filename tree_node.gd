class_name TreeNode extends Node2D

var assigned_position : Vector2
const move_rate: float = 0.1

func _ready() -> void:
	pass

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

func swap_to(target: Node2D) -> void:
	pass
