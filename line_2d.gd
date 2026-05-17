class_name ALine extends Line2D

var move_to_start: Vector2
var move_to_end: Vector2

var line_default_color: Color = Color(1.0, 1.0, 0.0, 1.0)
@onready var mid_point: MidLine = $MidPoint

func _ready() -> void:
	width = 20
	SignalBus.all_nodes_color_reset.connect(reset)	
	self.default_color = line_default_color
	mid_point.visible = false

func _process(delta: float) -> void:
	var move_rate: float = SignalBus.stimulation_speed * 5
	#position + (assigned_position - position) * move_rate
	self.set_point_position(0, self.get_point_position(0) + (move_to_start - self.get_point_position(0))*move_rate*delta)
	self.set_point_position(1, self.get_point_position(1) + (move_to_end - self.get_point_position(1))*move_rate*delta)

func set_pos(start, end):
	self.set_point_position(0, start)
	self.set_point_position(1, end)

func set_color(color: Color):
	self.default_color = color

func relocate(start, end):
	self.move_to_start = start
	self.move_to_end = end

func intermission(start, end, color: Color):
	mid_point.set_pos(start, start)
	mid_point.set_color(color)
	mid_point.visible = true
	mid_point.relocate(start, end)

func reset():
	self.default_color = line_default_color
	mid_point.visible = false
	
func set_normal() -> void:
	set_color(Color.YELLOW)

func set_new_node() -> void:
	set_color(Color.YELLOW)

func set_comparing() -> void:
	set_color(Color.ORANGE)

func set_visited() -> void:
	set_color(Color.GREEN)
	mid_point.visible = false
	
func set_swapping(up: bool) -> void:
	#print("HEHEHE")
	if up:
		intermission(move_to_end, move_to_start, Color.SKY_BLUE)
	else:
		intermission(move_to_start, move_to_end, Color.SKY_BLUE)
	#set_color(Color.GREEN)

func set_color_by_type(color_type: String, up: bool) -> void:
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
			set_swapping(up)
