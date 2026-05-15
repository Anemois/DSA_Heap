extends CanvasGroup

const A_LINE = preload("uid://y6h2l8oyaeyk")
@onready var tree: = $".."

var lines: Array[ALine] = [null]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func add_line(start, end, color):
	var newLine: ALine = A_LINE.instantiate()
	newLine.set_pos(start, start)
	newLine.relocate(start, end)
	newLine.set_color(color)
	self.add_child(newLine)
	lines.append(newLine)

func rearrange():
	var len = tree.length
	while(tree.length > lines.size() and tree.length >= 2):
		var i = lines.size()
		var parent = (i - 1) / 2
		add_line(tree.position + tree.nodes[parent].assigned_position, tree.position + tree.nodes[i].assigned_position, Color(0.945, 0.945, 0.0, 1.0))
		
	while(tree.length < lines.size() and lines.size() >= 1):
		lines.back().queue_free()
		lines.pop_back()
	
	for i in range(1, lines.size()):
		var parent = (i - 1) / 2
		lines[i].relocate(tree.position + tree.nodes[parent].assigned_position, tree.position + tree.nodes[i].assigned_position)
