extends CanvasGroup

const A_LINE = preload("uid://y6h2l8oyaeyk")
@onready var tree: = $".."

var lines: Array[ALine] = [null]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	rearrange()

func draw_a_line(start, end, color):
	var new: ALine = A_LINE.instantiate()
	new.set_pos(start, start)
	new.move_half_to(start, end)
	new.set_color(color)
	self.add_child(new)
	lines.append(new)

func rearrange():
	var len = tree.length
	while(tree.length > lines.size() && tree.length >= 2):
		var i = lines.size()
		var parent = (i - 1) / 2
		draw_a_line(tree.position + tree.nodes[parent].assigned_position, tree.position + tree.nodes[i].assigned_position, Color(0.945, 0.945, 0.0, 1.0))
		
	while(tree.length < lines.size() && lines.size() >= 3):
		lines.back().queue_free()
		lines.pop_back()
	
	for i in range(1, lines.size()):
		var parent = (i - 1) / 2
		lines[i].set_pos(tree.position + tree.nodes[parent].assigned_position, tree.position + tree.nodes[i].assigned_position)
