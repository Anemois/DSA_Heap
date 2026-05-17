class_name TreeNode extends Node2D
@onready var halo: Sprite2D = $Halo
@onready var label: Label = $Label
@onready var body: Sprite2D = $Body

var assigned_position : Vector2

func _ready() -> void:
	halo.visible = false
	halo.modulate = Color(0.997, 0.0, 0.0, 1.0)
	set_text_color(Color.BLACK)

func _process(delta: float) -> void:
	move(delta)

func move(delta) -> void:
	var move_rate: float = SignalBus.stimulation_speed * 5
	position = position + (assigned_position - position) * min(move_rate * (5 if abs(position.y) >= 4000 else 1) * delta, 1) 

func relocate(x: float, y: float) -> void:
	assigned_position = Vector2(x,  y)

func teleport(x: float, y: float) -> void:
	assigned_position = Vector2(x, y)
	position = assigned_position

func set_value(v: int) -> void:
	label.text = str(v)

func set_text_color(color: Color) -> void:
	label.add_theme_color_override("font_color", color)

func set_halo(visibility: bool) -> void:
	halo.visible = visibility

func get_assigned_position() -> Vector2:
	return assigned_position

func get_value() -> int:
	return int(label.text)

func get_halo() -> bool:
	return halo.visible

func set_normal() -> void:
	body.modulate = Color.WHITE
	set_halo(false)
	set_text_color(Color.BLACK)

func set_new_node() -> void:
	body.modulate = Color.YELLOW

func set_comparing() -> void:
	body.modulate = Color.ORANGE

func set_visited() -> void:
	body.modulate = Color.GREEN

func set_swapping() -> void:
	body.modulate = Color.SKY_BLUE

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
