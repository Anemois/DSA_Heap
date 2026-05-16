class_name TreeNode extends Node2D

var assigned_position : Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	move(delta)

func move(delta) -> void:
	var move_rate: float = SignalBus.stimulation_speed * 5
	position = position + (assigned_position - position) * move_rate * (5 if abs(position.y) >= 4000 else 1) * delta

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

func set_normal() -> void:
	$Sprite2D.modulate = Color.WHITE

func set_new_node() -> void:
	$Sprite2D.modulate = Color.YELLOW

func set_comparing() -> void:
	$Sprite2D.modulate = Color.ORANGE

func set_visited() -> void:
	$Sprite2D.modulate = Color.RED

func set_swapping() -> void:
	$Sprite2D.modulate = Color.SKY_BLUE

func set_color_by_type(color_type: String) -> void:
	match color_type:
		"normal":
			set_normal()
		"new":
			set_new_node()
		"compare":
			set_comparing()
		"visited":
			set_visited()
		"swap":
			set_swapping()
