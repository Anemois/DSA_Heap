class_name ALine extends Line2D

func set_pos(start, end):
	self.set_point_position(0, start)
	self.set_point_position(1, end)

func set_color(color: Color):
	self.default_color = color
