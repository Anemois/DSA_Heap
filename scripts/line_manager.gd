extends CanvasGroup

const A_LINE = preload("uid://y6h2l8oyaeyk")
@onready var tree: = $".."

var lines: Array[ALine] = [null]

func _ready() -> void:
	SignalBus.line_color_changed.connect(line_change_color)

func _process(delta: float) -> void:
	pass

func add_line(start, end):
	var newLine: ALine = A_LINE.instantiate()
	newLine.set_pos(start, start)
	newLine.relocate(start, end)
	self.add_child(newLine)
	lines.append(newLine)

func rearrange():
	var len = tree.length
	while(tree.length > lines.size() and tree.length >= 2):
		var i = lines.size()
		var parent = (i - 1) / 2
		add_line(tree.position + tree.nodes[parent].assigned_position, tree.position + tree.nodes[i].assigned_position)
		
	while(tree.length < lines.size() and lines.size() >= 2):
		lines.back().queue_free()
		lines.pop_back()
	
	for i in range(1, lines.size()):
		var parent = (i - 1) / 2
		lines[i].relocate(tree.position + tree.nodes[parent].assigned_position, tree.position + tree.nodes[i].assigned_position)

func line_change_color(index, color):
	lines[index].set_color_by_type(color)
