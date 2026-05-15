class_name ALine extends Line2D

var move_to_start: Vector2
var move_to_end: Vector2
var move_rate: float = SignalBus.stimulation_speed * 0.1

func _ready() -> void:
	width = 20

func _process(delta: float) -> void:
	#position + (assigned_position - position) * move_rate
	self.set_point_position(0, self.get_point_position(0) + (move_to_start - self.get_point_position(0))*move_rate)
	self.set_point_position(1, self.get_point_position(1) + (move_to_end - self.get_point_position(1))*move_rate)

func set_pos(start, end):
	self.set_point_position(0, start)
	self.set_point_position(1, end)

func set_color(color: Color):
	self.default_color = color

func relocate(start, end):
	self.move_to_start = start
	self.move_to_end = end
